#lang racket

;See https://youtu.be/AXJ9tTVGDwU

(require racket/gui/easy)

(define huge-font (font "Arial" 48 #:weight 'medium))
(define large-font (font "Arial" 18 #:weight 'medium))
(define normal-font (font "Arial" 12 #:weight 'medium))
(define small-font (font "Arial" 8 #:weight 'medium))
(define small-font-bold (font "Arial" 8 #:weight 'bold))

(render
 (window
  (spacer)
  (vpanel #:margin '(16 16)
   (text "Berrias-et-Casteljau" #:font large-font)
   (text "Auvergne-Rhône-Alpes" #:font normal-font)
   (hpanel #:margin '(0 0)
    (spacer)
    (text "☽" #:font huge-font)
    (text "16°" #:font huge-font)
    (choice '("C" "F")
            (λ (arg)
              (writeln (string-append "Choice: " arg)))) 
    (spacer))
   (text "Clear" #:font normal-font)
   (text "Updated as of 12:34" #:font small-font-bold)
   (hpanel
    (spacer)
    (text "Feels like 9°" #:font small-font)
    (text " · " #:font small-font)
    (text "Wind ↑ 1 mph" #:font small-font)
    (text " · " #:font small-font)
    (text "Visibility 12.4 mi" #:font small-font)
    (spacer))
   (hpanel
    (spacer)
    (text "Barometer 1016.00 mb" #:font small-font)
    (text " · " #:font small-font)
    (text "Humidity 77%" #:font small-font)
    (text " · " #:font small-font)
    (text "Dew Point 5°" #:font small-font)
    (spacer)))
  (spacer)))
  


