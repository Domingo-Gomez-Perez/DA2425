#lang racket


(define (cons x y) 
  (lambda (m) (m x y)))

(define (car z) 
  (z (lambda (p q) p)))

;Asi seria la misma representacion para cdr
(define (cdr z) 
  (z (lambda (p q) q)))

;Aqui se verifica que funciona dando por pantalla 1
(car (cons 1 0))

;Prueba para ver si funciona, sale por pantalla el 3
(cdr (cons 2 3))


