#lang racket
;Here is an alternative procedural representation of pairs. For this representation, verify that (car (cons x y)) yields x for any objects x and y.

(define (cons x y) 
  (lambda (m) (m x y)))

(define (car z) 
  (z (lambda (p q) p)))


;Podemos comprobar que funciona para cualquier valor
(car (cons 1 2))

(car (cons 5 6))

;Esto funciona debido a que cons x y crea una función que toma una función como argumento y le pasa el par x y.
;Mientras que "car" toma como argumento una funcion que ejecutara con el resultado de (lambda (p q) p)
;(lambda (p q) p) es una funcion que recibe dos argumentos y devuelve el de la izquierda

;Cuando usas car en un par creado por cons, extrae correctamente el primer valor porque cons pasa los dos valores a una función que car define para seleccionar el primero.

;Una definicion para cdr seria:
(define (cdr z)
  (z (lambda (p q) q)))