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

; primero vamos a ver como se forman los numeros de church. Vemos que son funciones
(define zero (lambda (f) (lambda (x) x)))
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))
(define three (lambda (f) (lambda (x) (f (f (f x))))))

; Si lo intentamos usar, vamos a ver que nos devuelve una funcion entonces para probar
; necesitamos una manera de volverlo numero

(define (inc x) (+ x 1))

((two inc) 4)

; ; ahora hay que definir la suma +
(define (add m n)
  (lambda (f) (lambda (x) ((m f) ((n f) x)))))

(((add two two)inc)0)
(((add three three)inc)0)

(define (exp m n)
  (lambda (f) (lambda (x) (((m n) f) x))))

(define (mult m n)
  (lambda (f) (lambda (x) ((m (n f)) x))))

(newline)
(((mult three three)inc)0)

;TAMBIEN HACER RESTA

; hay que llevar el numero y el anterior para hacerlo