#lang racket

;; See https://youtu.be/AXJ9tTVGDwU

(require racket/gui/easy)
(require racket/gui/easy/operator)

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

(define (weather-view state dispatch)
  (window
   (spacer)
   (vpanel
    #:margin '(16 16)
    (hpanel
     (input "" (λ (_event value)
                 (dispatch (vector-immutable 'change-query value))))
     (button "Search" (λ ()
                        (dispatch (vector-immutable 'submit-search)))))
    (spacer)
    (text (hash-ref state 'city) #:font large-font)
    (text (hash-ref state 'region) #:font normal-font)
    (hpanel
     #:margin '(0 0) 
     (spacer)
     (text (hash-ref state 'icon) #:font huge-font)
     (text (hash-ref state 'temp-real) #:font huge-font)
     (choice '("C" "F") on-change-temp-unit) 
     (spacer))
    (text (hash-ref state 'text-desc) #:font normal-font)
    (text (hash-ref state 'update-time) #:font small-font-bold)
    (hpanel
     (spacer)
     (text (hash-ref state 'temp-felt) #:font small-font)
     (text " · " #:font small-font)
     (text (hash-ref state 'wind) #:font small-font)
     (text " · " #:font small-font)
     (text (hash-ref state 'visibility) #:font small-font)
     (spacer))
    (hpanel
     (spacer)
     (text (hash-ref state 'pressure) #:font small-font)
     (text " · " #:font small-font)
     (text (hash-ref state 'humidity) #:font small-font)
     (text " · " #:font small-font)
     (text (hash-ref state 'dew-point) #:font small-font)
     (spacer)))
   (spacer)))

(define (weather-update state-hash message-vec)
  (define msg-key (vector-ref message-vec 0))
  (when (equal?  msg-key 'change-query)
    (define msg-val (vector-ref message-vec 1))
    (hash-set current-state-hash
              'query msg-val)))

(define @state (@ weather-init))

(define (on-change-temp-unit arg)
  (printf "TODO: change temperature unit to: ~a~n" arg))

(define (on-submit-search)
  (printf "TODO: execute search~n"))

(define current-state-hash (obs-peek @state))

(render 
 (weather-view
  current-state-hash
  (λ (message-vec)
    (define new-state-hash 
      (weather-update current-state-hash message-vec))
    (:= @state new-state-hash))))

