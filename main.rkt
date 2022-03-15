#lang racket

;; See https://youtu.be/AXJ9tTVGDwU

(require racket/gui/easy)
(require racket/gui/easy/operator)
(require "weather.rkt")

(define @state (@ weather-init))

(define current-state-hash (obs-peek @state))

(define (handle-effect effect-vec dispatch)
  (when (vector? effect-vec)
    (define effect-key (vector-ref effect-vec 0))
    (define effect-val (vector-ref effect-vec 1))
    (cond [(equal? effect-key 'fx-log)
           (printf "~a~n" effect-val)])))

(define (dispatch message-vec)
  (define update-result-vec 
    (weather-update current-state-hash message-vec))
  (define new-state-hash (vector-ref update-result-vec 0))
  (define new-effect-vec (vector-ref update-result-vec 1))
  (handle-effect new-effect-vec dispatch)
  (:= @state new-state-hash))

(render 
 (weather-view
  current-state-hash
  dispatch))

