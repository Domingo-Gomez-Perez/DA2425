#lang racket
; Ejercicio 2.4

(define (cons x y) 
  (lambda (m) (m x y)))

(define (car z) 
  (z (lambda (p q) p)))

(define (cdr z) (
   z (lambda (p q) q)
                 ))

(car (cons 2 3))

(cdr (cons 2 3))
