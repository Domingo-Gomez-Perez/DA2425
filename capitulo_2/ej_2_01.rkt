#lang racket

; Exercise 2.1

; Define a better version of `make-rat` that handles both positive and negative arguments.
; `make-rat` should normalize the sign so that if the rational number is positive, both the 
; numerator and denominator are positive, and if the rational number is negative, only the 
; numerator is negative.

(define (make-rat numer denom)
  (define (negate x)
    (- 0 x))

  ; Case numer/-denom || -numer/-denom
  (if (< denom 0) 
      (cons (negate numer) (negate denom))
      (cons numer denom)
      )
)

; Both possitives
(make-rat 4 5)
(make-rat -4 -5)

; Numer negative
(make-rat -4 5)
(make-rat 4 -5)         