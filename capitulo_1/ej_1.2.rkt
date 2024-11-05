#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 1.2: Translate the following expression into prefix form.

5 + 4 + (2 - (3 - (6 + 4/5)))
-----------------------------
       3(6 - 2)(2 - 7)

|#

; Numerador:
; 5 + 4 + (2 - (3 - (6 + 4/5)))

;Prefix form:
(+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))

; Denominador
; 3(6 - 2)(2 - 7)

;Prefix form:
(* 3 (- 6 2) (- 2 7))

; todo junto
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))

