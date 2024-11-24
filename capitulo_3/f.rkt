#lang racket

(define valor -1/2)
(define (f x)
    (set! valor (+ valor x))
    valor)

(define (f2 x)
  (let ((valor 0))
    (set! valor (+ valor x))
    valor))



(+ (f 0) (f 1)) ; 0
(+ (f 1) (f 0)) ; 1