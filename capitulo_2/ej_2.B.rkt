#lang racket

#|
Hecho por 
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.B: Modify the "bob" and "alice" code to use tags. Verify that all of the old code still works.

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(alice-area a)
; 4
(bob-area b)
; 12

; Look at the resulting data structures
a   ; -> '(bob-box (1 . 2) 3 . 4)
b   ; -> '(alice-box (1 . 2) 3 . 4)
|#
