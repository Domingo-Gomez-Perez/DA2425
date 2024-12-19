#lang racket

(define (square x) (* x x))
(define (inc x) (+ x 1))

(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (< b a)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(accumulate + 1 square 1 inc 5)
(accumulate * 0 square 1 inc 5)