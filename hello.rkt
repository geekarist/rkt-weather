#lang racket/gui

(define frame (new frame% [label "Example"]))

(send frame show #t)

(define msg (new message%
                 [parent frame]
                 [label "No events so far..."]))

(new button%
     [parent frame]
     [label "Click here!"]
     [callback (lambda (button event)
                 (send msg set-label "Button click"))])
     