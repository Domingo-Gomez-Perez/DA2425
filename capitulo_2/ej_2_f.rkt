#lang racket

; Exercise 2.F

; Reimplement the "alice" and "bob" code as message passing.


; Bob's box
(define (make-bob-box x y width height)
  (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'area) (* width height))
          ((eq? message 'type) 'bob-box)
          )
    )
  dispatch
)

; Tests
(display "Bob's Tests:")(newline)
(define b (make-bob-box 1 2 3 4))
(b 'width)     ; Should return 3
(b 'height)    ; Should return 4
(b 'area)      ; Should return 12
(b 'type)      ; Should return 'bob-box



; Alice's box
(define (make-alice-box x1 y1 x2 y2)
  (define (dispatch message)
    (cond ((eq? message 'width) (abs (- x2 x1)))
          ((eq? message 'height) (abs (- y2 y1)))
          ((eq? message 'area) (* (abs (- x2 x1)) (abs (- y2 y1))))
          ((eq? message 'type) 'alice-box)
          )
    )
  dispatch
)

; Tests
(newline)(display "Alice's Tests:")(newline)
(define a (make-alice-box 1 2 3 4))
(a 'width)     ; Should return 2
(a 'height)    ; Should return 2
(a 'area)      ; Should return 4
(a 'type)      ; Should return 'alice-box