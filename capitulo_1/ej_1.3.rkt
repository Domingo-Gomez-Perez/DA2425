#lang racket

;Hecho por 
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Exercise 1.3: Define a procedure that takes three numbers as arguments and returns 
the sum of the squares of the two larger numbers.
|#

;Funcion auxiliar para sumar dos cuadrados
(define (SumaSquare x y)
  (+ (* x x) (* y y)))

;Escogemos los numeros mas grandes
(define (cuadrados x y z)
  ; Determinamos cuales son los numeros mas grandes
  (cond
    ; Caso x es mayor o igual al mayor.
    [(and (>= x y) (>= x z))
     (SumaSquare x (if (>= y z) y z))]
    ; Caso y es mayor o igual al mayor.
    [(and (>= y x) (>= y z))
     (SumaSquare y (if (>= x z) x z))]
    ; Caso z es mayor o igual al mayort.
    [(and (>= z x) (>= z y))
     (SumaSquare z (if (>= x y) x y))]))

(cuadrados 2 3 4) ;tiene que dar 25 y da 25
(cuadrados 2 2 2) ;tiene que dar 8 y da 8
(cuadrados 4 7 9) ;tiene que dar 130 y da 130
