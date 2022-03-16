#lang racket

;; See https://youtu.be/AXJ9tTVGDwU

(require racket/gui/easy)
(require racket/gui/easy/operator)

(define weather-init
  (hash 'weather "Please search a city and click 'Search'"
        'query ""))

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
        (hash-ref state-hash 'query)))))))

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
       (printf "Execute search: ~a~n" msg-val)]))))

