#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.5: Show that we can represent pairs of nonnegative integers using only 
numbers and arithmetic operations if we represent the pair a and b as the integer 
that is the product 2^a * 3^b. Give the corresponding definitions of the procedures 
cons, car, and cdr.
|#

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (car z)
  (define (factorize n base)
    (if (= (modulo n base) 0)
        (+ 1 (factorize (/ n base) base))
        0))
  (factorize z 2))

(define (cdr z)
  (define (factorize n base)
    (if (= (modulo n base) 0)
        (+ 1 (factorize (/ n base) base))
        0))
  (factorize z 3))

; pruebas
(define punto (cons 2 3)) ; punto representaría (2, 3)
(car punto) ; debería dar 2
(cdr punto) ; debería dar 3


