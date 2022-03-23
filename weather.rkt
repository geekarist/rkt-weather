#lang racket

(require racket/gui/easy)
(require racket/gui/easy/operator)

(define init
  (hash 'query ""
        'result "Please type a search string and click 'Search'"
        'pending-effect null))

(define (view get-state-prop dispatch)
  (define (on-change-query _event query)
    (dispatch (vector-immutable 'change-query query)))
  (define (on-execute-search)
    (dispatch (vector-immutable 'execute-search null)))
  (window
   (vpanel
    (input "" on-change-query)
    (button "Search" on-execute-search)
    (text (get-state-prop 'result)))))

(define (update-on-execute-search current-state-hash msg-val)
  (define query (hash-ref current-state-hash 'query))
  (define new-result (format "Searching for ~a, please wait..." query))
  (define new-effect (vector-immutable 'fx-log query))
  (define state-with-new-result
    (hash-set* current-state-hash
               'result new-result
               'pending-effect new-effect))
  state-with-new-result)

(define (update-on-change-query current-state-hash msg-val)
  (define new-query msg-val)
  (define new-state
    (hash-set current-state-hash 'query new-query))
  new-state)

(define (update current-state-hash msg-vec)
  (define msg-key (vector-ref msg-vec 0))
  (define msg-val (vector-ref msg-vec 1))
  (cond
    [(equal? msg-key 'change-query)
     (update-on-change-query current-state-hash msg-val)]
    [(equal? msg-key 'execute-search)
     (update-on-execute-search current-state-hash msg-val)]))

(define weather-program
  (hash 'init init
        'view view
        'update update))

(provide weather-program)
