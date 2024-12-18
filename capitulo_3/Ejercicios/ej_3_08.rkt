#lang racket
(define valor 0)
(define (f x)
  (cond
   ((= x 0) (set! valor -1))
   (else (set! valor (+ (+ valor x) 1))))
   valor)


;(+ (f 0) (f 1))

(+ (f 1) (f 0))

