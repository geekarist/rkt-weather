#lang racket

;; See https://youtu.be/AXJ9tTVGDwU

(require "weather.rkt")
(require racket/gui/easy)

(render
 (weather-view
  weather-init
  (λ (msg)
    (writeln msg))))
