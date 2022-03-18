#lang racket

(require racket/gui/easy)
(require racket/gui/easy/operator)

(define weather-init
  (hash 'query ""
	'result "Please type a search string and click 'Search'"))

(define (weather-view get-state-prop dispatch)
  (define (on-change-query _event query)
    (dispatch (vector-immutable 'change-query query)))
  (define (on-execute-search)
    (dispatch (vector-immutable 'execute-search null)))
  (window
   (vpanel
    (input "" on-change-query)
    (button "Search" on-execute-search)
    (text (get-state-prop 'result)))))

(define (weather-update current-state-hash msg-vec)
  (define msg-key (vector-ref msg-vec 0))
  (define msg-val (vector-ref msg-vec 1))
  (cond
    [(equal? msg-key 'change-query)
     (define new-query msg-val)
	 (define new-state 
	   (hash-set current-state-hash 'query new-query))
	 new-state]
    [(equal? msg-key 'execute-search)
     (define query (hash-ref current-state-hash 'query))
     (define new-result (format "TODO3: search result for ~a" query))
	 (define new-state
	   (hash-set current-state-hash 'result new-result))
	 (define new-effect (lambda (fx-key fx-val)
						  (printf "~a: ~a~n" fx-key fx-val)))
	 new-state]))

(define weather-program
  (hash 'init weather-init
        'view weather-view
        'update weather-update))

(provide weather-program)
