#lang racket

(require "weather.rkt")
(require "runtime.rkt")

(runtime (hash-ref weather-program 'init)
         (hash-ref weather-program 'view)
         (hash-ref weather-program 'update))