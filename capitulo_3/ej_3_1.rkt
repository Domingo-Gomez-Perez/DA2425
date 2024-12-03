#lang racket

(define (make-accumulator initial-value)
  (define (acumula x)
    (begin (set! initial-value (+ initial-value x))
           (displayln initial-value)))
  acumula)
                
(define A (make-accumulator 2))

(A 20)

(A 10)