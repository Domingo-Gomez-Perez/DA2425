#lang racket

;EJERCICIO 1.41

(define (inc x) (+ x 1))

(define (double func)
  (lambda (x) (func (func x))))


(((double (double double)) inc) 5)
;(5 + 2 ^ ((inc * 2)* 2)) = 21