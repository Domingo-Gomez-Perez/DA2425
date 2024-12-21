#lang racket
(define (mul a b)
  (cond ((= b 0) 0)
        ((= b 1) a)
        ((even? a) (mul (double a) (halve b)))
        (else
        (+ a (mul a (- b 1))))
        )
  )

(define (double x)
  (arithmetic-shift x 1))

(define (halve x)
  (arithmetic-shift x -1))

(mul 10 20)