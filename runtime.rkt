#lang racket

;; See https://youtu.be/AXJ9tTVGDwU
(require racket/gui/easy)
(require racket/gui/easy/operator)

(provide runtime)

(define (obs-map-hash-ref @state key)
  (obs-map @state
           (λ (state-hash)
             (hash-ref state-hash key))))

(define (handle-effect! effect-vec)
  (when (not (null? effect-vec))
    (define effect-key (vector-ref effect-vec 0))
    (define effect-val (vector-ref effect-vec 1))
    (cond
      [(equal? effect-key 'fx-log)
       (printf "Log: ~a~n" effect-val)])))

(define (runtime init view update)
  (define @state (@ init))
  (define (get-state key) (obs-map-hash-ref @state key))
  (define (dispatch msg-vec)
    (define current-state-hash (obs-peek @state))
    (define new-effect-vec
      (hash-ref current-state-hash 'pending-effect))
    (handle-effect! new-effect-vec)
    (define new-state-hash
      (update current-state-hash msg-vec))
    (define new-state-hash-cleared-effect
      (hash-set new-state-hash 'pending-effect null))
    (obs-update! @state
                 (λ (_current-state-hash)
                   new-state-hash-cleared-effect)))
  (render
   (view get-state dispatch)))
