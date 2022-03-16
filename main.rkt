#lang racket

;; See https://youtu.be/AXJ9tTVGDwU

(require racket/gui/easy)
(require racket/gui/easy/operator)

(define weather-init
  (hash
   'query ""
   'result "Please type a search string and click 'Search'"
   ))

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
    (text
     (@state
      . ~> .
      (λ (state-hash)
        (hash-ref state-hash 'result)))))))

(define (weather-update state-hash msg)
  "TODO")

(define @state-global
  (@ weather-init))

(render
 (weather-view
  @state-global
  (λ (msg-vec)
    (define msg-key (vector-ref msg-vec 0))
    (define msg-val (vector-ref msg-vec 1))
    (define current-state-hash (obs-peek @state-global))
    (cond
      [(equal? msg-key 'change-query)
       (obs-update!
        @state-global
        (λ (current-state-hash)
          (define new-query msg-val)
          (define new-state-hash
            (hash-set current-state-hash 'query new-query))
          new-state-hash))]
      [(equal? msg-key 'execute-search)
       (define query (hash-ref current-state-hash 'query))
       (define new-result (format "TODO: search result for ~a" query))
       (obs-update! @state-global
                    (λ (current-state-hash)
                      (hash-set current-state-hash 'result new-result)))]))))

