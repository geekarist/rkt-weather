#lang racket

(require racket/gui/easy)
(require racket/gui/easy/operator)

(provide weather-init weather-view weather-update)

(define huge-font (font "Arial" 48 #:weight 'medium))
(define large-font (font "Arial" 18 #:weight 'medium))
(define normal-font (font "Arial" 12 #:weight 'medium))
(define small-font (font "Arial" 8 #:weight 'medium))
(define small-font-bold (font "Arial" 8 #:weight 'bold))

(define weather-init
  (hash 'query null
        'city "Berrias-et-Casteljau"
        'region "Auvergne-Rhône-Alpes"
        'icon "☽"
        'text-desc "Clear"
        'update-time "Updated as of 12:34"
        'temp-real "16°"
        'temp-felt "Feels like 9°"
        'wind "Wind ↑ 1 mph"
        'visibility "Visibility 12.4 mi"
        'pressure "Barometer 1016.00 mb"
        'humidity "Humidity 77%"
        'dew-point "Dew Point 5°"))

(define (weather-view state-hash dispatch)
  (window
   (spacer)
   (vpanel
    #:margin '(16 16)
    (hpanel
     (input "" (λ (_event value)
                 (dispatch (vector-immutable 'change-query value))))
     (button
      "Search"
      (λ ()
        (dispatch (vector-immutable
                   'log-value (hash-ref state-hash 'query))))))
    (spacer)
    (text (hash-ref state-hash 'city) #:font large-font)
    (text (hash-ref state-hash 'region) #:font normal-font)
    (hpanel
     #:margin '(0 0) 
     (spacer)
     (text (hash-ref state-hash 'icon) #:font huge-font)
     (text (hash-ref state-hash 'temp-real) #:font huge-font)
     (choice '("C" "F") (λ (value)
                          (dispatch (vector-immutable 'log-value value)))) 
     (spacer))
    (text (hash-ref state-hash 'text-desc) #:font normal-font)
    (text (hash-ref state-hash 'update-time) #:font small-font-bold)
    (hpanel
     (spacer)
     (text (hash-ref state-hash 'temp-felt) #:font small-font)
     (text " · " #:font small-font)
     (text (hash-ref state-hash 'wind) #:font small-font)
     (text " · " #:font small-font)
     (text (hash-ref state-hash 'visibility) #:font small-font)
     (spacer))
    (hpanel
     (spacer)
     (text (hash-ref state-hash 'pressure) #:font small-font)
     (text " · " #:font small-font)
     (text (hash-ref state-hash 'humidity) #:font small-font)
     (text " · " #:font small-font)
     (text (hash-ref state-hash 'dew-point) #:font small-font)
     (spacer)))
   (spacer)))

(define (weather-update state-hash message-vec)
  (define msg-key (vector-ref message-vec 0))
  (define msg-val (vector-ref message-vec 1))
  (cond [(equal?  msg-key 'change-query)
         (define new-state-hash
           (hash-set state-hash 'query msg-val))
         (define new-effect-vec null)
         (vector-immutable new-state-hash new-effect-vec)]
        [(equal? msg-key 'log-value)
         (define new-state-hash state-hash)
         (define new-effect-vec (vector-immutable 'fx-log msg-val))
         (vector-immutable new-state-hash new-effect-vec)]))