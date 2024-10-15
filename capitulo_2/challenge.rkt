#lang racket
(define (sub x y)
  (y (lambda (z) (lambda (a) a)) x))
