#lang racket
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;La operación realiza la "suma absoluta" entre dos valores.
;Para ello, comprueba si b es mayor o menor que 0. Si es mayor,
;el "if" devuelve un "+" y se realiza una suma normal. Si es
;menor, entonces b es 0 o negativo y devuelve "-". De esta forma,
;el menos aportado al valor se compensa con el menos de la
;condición y se realiza la suma.