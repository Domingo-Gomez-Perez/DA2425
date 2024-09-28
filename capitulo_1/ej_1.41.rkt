#lang racket

; Hecho por:
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Exercise 1.41:
Define a procedure `double` that takes a procedure of one argument as an argument 
and returns a procedure that applies the original procedure twice.

For example, if `inc` is a procedure that adds 1 to its argument, then `(double inc)`
should be a procedure that adds 2.

What value is returned by:

(((double (double double)) inc) 5)
|#

; definicion del inc
(define (inc x) (+ x 1))


; Definición de la función double
(define (double proc)
  (lambda (x) (proc (proc x)))) ; Aplica proc dos veces

; prueba
(((double (double double)) inc) 5) ; => 21

#|
Hay que aplicar el doble un total de 3 veces por lo que en total será 2^2^2 que es 16.
Al sumar 16 a 5, nos queda 21.
|#
