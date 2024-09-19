#lang racket

(define (square x) (* x x))
(define (inc x) (+ x 1))

;Versión iterativa:
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(accumulate + 0 square 1 inc 4) ;0^2 + 1^2 + 2^2 + 3^2 + 4^2
(accumulate * 0 square 1 inc 4) ;Ha de dar 0
(accumulate * 1 square 1 inc 4) ;1^2 * 2^2 * 3^2 * 4^2