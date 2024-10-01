#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.6: In case representing pairs as procedures wasn't mind-boggling enough, 
consider that, in a language that can manipulate procedures, we can get by without 
numbers (at least insofar as nonnegative integers are concerned) by implementing 
0 and the operation of adding 1 as

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

This representation is known as "Church numerals," after its inventor, Alonzo Church, 
the logician who invented the λ-calculus.

Define one and two directly (not in terms of zero and add-1). (Hint: Use substitution to 
                                                               evaluate (add-1 zero)). Give a direct definition of the addition procedure + 
(not in terms of repeated application of add-1).
|#

; Definición de los números de Church
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))
(define three (lambda (f) (lambda (x) (f (f (f x))))))

; Función sucesor para incrementar un número de Church
(define (sucesor numero) 
  (lambda (f) 
    (lambda (x) 
      (f ((numero f) x)))))

; Ejemplo de función que incrementa un valor
(define (inc x) (+ x 1))

; Prueba con el número two
(((sucesor two) inc) 0) ; Debería devolver 3
