#lang racket
(define (cons x y) 
  (lambda (m) (m x y)))

(define (car z) 
  (z (lambda (p q) p)))
(define (cdr z) 
  (z (lambda (p q) q)))

(car (cons 1 2))
(car (cons -1 2))
(car (cons 1 (cons 2 3)))
(car (cons (cons 1 (cons 2 3)) 4)) 

(cdr (cons 1 2))
(cdr (cons -1 2))
(cdr (cons 1 (cons 2 3)))
(cdr (cons (cons 1 (cons 2 3)) 4))

;retorna procedure porque no es el cons de verdad sino una funcion a la que se pueden aplicar otras funciones
;ejemplo: (cdr (cons 1 (cons 2 3))) retorna (cons 2 3) pero como no es un valor almacenado no se muestra 2.3 sino que es una función 