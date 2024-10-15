#lang racket
(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (car n)
  (define (count-divisions-by-2 x)
    (if (zero? (remainder x 2))
        (+ 1 (count-divisions-by-2 (/ x 2)))
        0))
  (count-divisions-by-2 n))

(define (cdr n)
  (define (count-divisions-by-3 x)
    (if (zero? (remainder x 3))
        (+ 1 (count-divisions-by-3 (/ x 3)))
        0))
  (count-divisions-by-3 n))

(define pair (cons 3 6))
(car pair)
(cdr pair)
