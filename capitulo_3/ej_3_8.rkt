#lang racket
(define valor 'z)
(define (f x)
  (if (symbol? valor)
      (set! valor x)
      valor)
  valor
  )

;(+ (f 0) (f 1))
(+ (f 1) (f 0))