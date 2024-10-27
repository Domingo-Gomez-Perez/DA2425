#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.4: Here is an alternative procedural representation of pairs.
For this representation, verify that (car (cons x y)) yields x for any
objects x and y.

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

What is the corresponding definition of cdr? (Hint: To verify that this works,
make use of the substitution model of section 1.1.5)
|#

; definiciones
(define (cons x y)
  (lambda (m) (m x y)))

; para el car cogemos el primer elemento
(define (car z)
  (z (lambda (p q) p)))

; para el cdr cogemos el segundo elemento
(define (cdr z)
  (z (lambda (p q) q)))

; en ambos casos especificamos que z esta compuesto por dos elementos
; y elegimos cual de los dos escogemos

; pruebas
(define punto (cons 1 2))
(car punto)   ; => 1
(cdr punto)   ; => 2


