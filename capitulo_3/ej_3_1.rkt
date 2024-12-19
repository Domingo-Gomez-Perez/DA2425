#lang racket
;Ejercicio 3.1

(define (make-accumulator n)
  (define (sum x)
    (set! n (+ n x))
    display n)
    sum)

(define a (make-accumulator 5))
(define b (make-accumulator 10))

(a 10)
;15
(b 10)
;20

(a 10)
;25
(b 10)
;30