#lang racket

;; See https://youtu.be/AXJ9tTVGDwU

(require racket/gui/easy)
(require racket/gui/easy/operator)

(define weather-init
  (hash 'weather "Please search a city and click 'Search'"
        'query ""))

(define (weather-view state-hash dispatch)
  (window
   (vpanel
    (input ""
           (λ (event query)
             (dispatch (vector-immutable 'change-query query))))
    (button
     "Search"
     (λ ()
       (dispatch (vector-immutable 'execute-search null))))
    (text (hash-ref state-hash 'weather)))))

(define (weather-update state-hash msg)
  "TODO")

(define global-state-hash
  (hash 'weather
        (@ (hash-ref weather-init 'weather))
        'query
        (@ (hash-ref weather-init 'query))))

(render
 (weather-view
  global-state-hash
  (λ (msg-vec)
    (define msg-key (vector-ref msg-vec 0))
    (define msg-val (vector-ref msg-vec 1))
    (cond
      [(equal? msg-key 'change-query)
       (obs-update!
        (hash-ref global-state-hash 'query)
        (λ (weather-val) msg-val))]
      [(equal? msg-key 'execute-search)
       (printf "Execute search: ~a~n" msg-val)]))))

