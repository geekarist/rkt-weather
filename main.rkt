#lang racket

;; See https://youtu.be/AXJ9tTVGDwU

(require racket/gui/easy)
(require racket/gui/easy/operator)
(require "weather.rkt")

(define (obs-map-hash-ref @state key)
  (obs-map @state
           (λ (state-hash)
             (hash-ref state-hash key))))

(define (runtime init view update)
  (define @state (@ init))
  (render
   (view
    (λ (key)            ; Get state function
      (obs-map-hash-ref @state key))
    (λ (msg-vec)        ; Dispatch function
      (define current-state-hash (obs-peek @state))
      (define new-state-hash
        (update current-state-hash msg-vec))
      (obs-update! @state
                   (λ (_current-state-hash)
                     new-state-hash))))))

(runtime (hash-ref weather-program 'init)
         (hash-ref weather-program 'view)
         (hash-ref weather-program 'update))

