#lang racket
(define valor 0)
(define (f x)
  (set! valor (+ valor x))
  valor
  )

;(+ (f 0) (f 1))
(+ (f 1) (f 0))