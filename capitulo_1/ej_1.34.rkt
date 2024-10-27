#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 1.34: Suppose we define the procedure:

(define (f g) (g 2))

Then we have:
(f square)
4

(f (lambda (z) (* z (+ z 1))))
6

What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? Explain.
|#


#|
Al intentar evaluar la combinacion (f f) lo que ocurre es:
(f f) -> (f 2)

Esto significa que el procedimiento f trata de aplicar f al número 2. Pero f no es el procedimiento que acepte números directamente,
sino que espera una función como argumento.
Por lo tanto, se produce un error, ya que f intenta evaluar 2 como si fuera un procedimiento.
|#

(define (f g) (g 2))
(define (square x) (* x x))

(f square)
; 4

(f (lambda (z) (* z (+ z 1))))
; 6

(f f)