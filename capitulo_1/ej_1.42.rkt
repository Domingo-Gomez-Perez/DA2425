#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 1.42: Let f and g be two one-argument functions. The composition f after g is defined
to be the function that maps x to f(g(x)).

Define a procedure `compose` that implements composition. For example, if `inc`
is a procedure that adds 1 to its argument:

((compose square inc) 6)    ; -> 49
|#

; Definición de la función compose
(define (compose f g)
  (lambda (x) (f (g x))))  ; Aplica g a x y luego f al resultado


; funciones para probar
(define (inc x) (+ x 1))
(define (square x) (* x x))

; Prueba
((compose square inc) 6)  ; => 49 (hace el incremento y hace el cuadrado de 7)

