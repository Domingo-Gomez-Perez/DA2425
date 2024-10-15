#lang racket
;Ejercicio 2.6

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;1
(define one (lambda (f) (lambda (x) (f x))))


;2
(define two (lambda (f) (lambda (x) (f (f x)))))

;suma
(define (suma x y) (lambda (f) (lambda (z) ((x f) ((y f) z)))))