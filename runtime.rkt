#lang racket

;; See https://youtu.be/AXJ9tTVGDwU
(require racket/gui/easy)
(require racket/gui/easy/operator)

(provide runtime)

(define (obs-map-hash-ref @state key)
  (obs-map @state
           (λ (state-hash)
             (hash-ref state-hash key))))

(define (runtime init view update)
  (define @state (@ init))
  (define (get-state key) (obs-map-hash-ref @state key))
  (define (dispatch msg-vec)
    (define current-state-hash (obs-peek @state))
    (define new-state-hash
      (update current-state-hash msg-vec))
    (obs-update! @state
                 (λ (_current-state-hash)
                   new-state-hash)))
  (render
   (view get-state dispatch)))
