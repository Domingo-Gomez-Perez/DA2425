#lang racket
(define (double pr)
  (lambda (x) (pr (pr x)))
  )
(define (inc x)
  (+ x 1))

(((double (double double)) inc) 5)

