#lang racket

;Hecho por 
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Exercise 1.2: Translate the following expression into prefix form.

5 + 4 + (2 - (3 - (6 + 4/5)))
-----------------------------
       3(6 - 2)(2 - 7)

|#

;Original expression:
5 + 4 + (2 - (3 - (6 + 4/5)))

;Prefix form:
(+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))

;Original expression:
3(6 - 2)(2 - 7)

;Prefix form:
(* 3 (* (- 6 2) (- 2 7)))

;combine
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (* (- 6 2) (- 2 7))))

