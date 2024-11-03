#lang racket
;Let f and g be two one-argument functions. The composition f after g is defined to be the function that maps x to f(g(x)).
;Define a procedure compose that implements composition. For example, if inc is a procedure that adds 1 to its argument,
;(define (square x) (* x x))
;(define (inc x) (+ x 1))
;((compose square inc) 6)    ; -> 49

;Defino f como funcion que multiplica por 6
(define (f x) (* x 6))

;Defino g como funcion que resta 2
(define (g x) (- x 2))

;Funcion composicion
(define (composition x) ((compose g f) x))

(composition 3)
;16