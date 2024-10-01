#lang racket

#|
Hecho por 
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.A: Enter the above code for Bob's and Alice's box. Verify that it works and look at the resulting data structures:

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))
(alice-area a)
; 4
(bob-area b)
; 12

; Look at the resulting data structures
a        ; -> '((1 . 2) 3 . 4)
b        ; -> '((1 . 2) 3 . 4)
|#
