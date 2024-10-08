#lang racket
; original
(define (make-rat numer denom)
  (cons numer denom))

; mejor
(define (make-rat-2 numer denom)
  (if (< denom 0)
      (cons (- 0 numer) (- 0 denom))
      (cons numer denom)))

; comprobar
(make-rat-2 2 3)
(make-rat-2 -2 3)
(make-rat-2 -2 -3)
(make-rat-2 2 -3)
