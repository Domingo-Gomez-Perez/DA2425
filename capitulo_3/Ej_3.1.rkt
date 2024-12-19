#lang racket
(define (make-accumulator x)
  (let ((sum x))
  (lambda (y)
    (set! sum (+ sum y))
    sum)))

(define A (make-accumulator 10))
(define B (make-accumulator 5))
(A 10)
(B 5)
(A 10)