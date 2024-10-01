#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.18: Define a procedure reverse that takes a list as argument and 
returns a list of the same elements in reverse order:

(reverse (list 1 4 9 16 25))
; => '(25 16 9 4 1)

Bonus: Can you design an algorithm that requires only n steps for a list containing n items?
|#


;esta bien???

; Versión recursiva para revertir una lista
(define (reverse lst)
  (define (reverse-iter lst acc)
    (if (null? lst)
        acc
        (reverse-iter (cdr lst) (cons (car lst) acc))))
  (reverse-iter lst '()))

; pruebas
(reverse (list 1 4 9 16 25)) ; => '(25 16 9 4 1)
