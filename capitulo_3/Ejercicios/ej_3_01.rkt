#lang racket
(define (make-accumulator x)
  (define (acumular y)
    (set! x (+ x y))
    (displayln x))
  acumular)


(define A (make-accumulator 5))

(A 10)

(A 10)