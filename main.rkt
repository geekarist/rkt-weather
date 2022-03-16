#lang racket

;; See https://youtu.be/AXJ9tTVGDwU

(require racket/gui/easy)
(require racket/gui/easy/operator)

(define weather-init
  (hash
   'query ""
   'result "Please type a search string and click 'Search'"
   ))

(define (obs-hash-ref @state key)
  (obs-map @state
           (λ (state-hash)
             (hash-ref state-hash key))))

(define (weather-view @state dispatch)
  (window
   (vpanel
    (input ""
           (λ (event query)
             (dispatch (vector-immutable 'change-query query))))
    (button
     "Search"
     (λ ()
       (dispatch (vector-immutable 'execute-search null))))
    (text (obs-hash-ref @state 'result)))))

(define (weather-update current-state-hash msg-vec)
  (define msg-key (vector-ref msg-vec 0))
  (define msg-val (vector-ref msg-vec 1))
  (cond
    [(equal? msg-key 'change-query)
     (define new-query msg-val)
     (hash-set current-state-hash 'query new-query)]
    [(equal? msg-key 'execute-search)
     (define query (hash-ref current-state-hash 'query))
     (define new-result (format "TODO: search result for ~a" query))
     (hash-set current-state-hash 'result new-result)]))

(define (runtime init view update)
  (define @state-global
    (@ init))
  (render
   (view
    @state-global
    (λ (msg-vec)
      (define current-state-hash (obs-peek @state-global))
      (define new-state-hash
        (update current-state-hash msg-vec))
      (obs-update! @state-global
                   (λ (_current-state-hash)
                     new-state-hash))))))

(runtime weather-init weather-view weather-update)