#lang racket

(define (make-accumulator n)
  (lambda (incremento)
    (set! n (+ n incremento))
    n))

(define A (make-accumulator 5))

(A 10)
15

(A 10)
25