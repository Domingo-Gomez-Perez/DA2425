#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 1.3: Define a procedure that takes three numbers as arguments and returns
the sum of the squares of the two larger numbers.
|#

; necesitamos encontrar los dos mas grandes, por lo que necesitamos un maximo
; existe la funcion max asi que sin problema
;Funcion para sumar dos cuadrados
(define (suma-square x y)
  (+ (* x x) (* y y)))

;Escogemos los numeros mas grandes
(define (cuadrados x y z)
  ; variables para guardar el primer maximo y el segundo
  (define max1 (max x y))
  (define max2 (max (min x y) z))
  ; Determinamos cuales son los numeros mas grandes
  (suma-square max1 max2))

(cuadrados 2 3 4) ;tiene que dar 25 y da 25
(cuadrados 2 2 2) ;tiene que dar 8 y da 8
(cuadrados 4 7 9) ;tiene que dar 130 y da 130
