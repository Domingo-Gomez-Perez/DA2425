#lang racket

(define (square x) (* x x))
(define (inc x) (+ x 1))

;Recursivo
(define (accumulate combiner null-value term a next b)
  (if (< b a)
      null-value
      (combiner (term a)
         (accumulate combiner null-value term (next a) next b))))

(accumulate + 0 square 1 inc 5)
(accumulate * 0 square 1 inc 5)