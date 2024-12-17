#lang racket
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result)))
    )
  (iter a 0)
)

(define (increase x) (+ x 1))
(define (square x) (* x x))

(sum square 1 increase 4) ; suma los cuadrados del 1 al 4