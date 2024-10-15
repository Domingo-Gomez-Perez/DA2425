#lang racket
(define (double f)
  (lambda (x)
    (f (f x))))

(define (inc x)
  (+ x 1))

((double inc) 3) ; -> 5
(((double (double double)) inc) 5) ; -> 21 = 2^4 + 5
