#lang racket

;Exercise 1.4: Observe that our model of evaluation allows for combinations whose operators are compound expressions. 
;Use this observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; Lo que hace este procedimiento depende del signo de b. Si b es positivo, el operador
; es + y si b es negativo el operador es -. En otras palabras, si b es positivo, el 
; procedimiento devuelve a + b, y si b es negativo, devuelve a - b. Por lo tanto la 
; el procedimiento siempre va a devolver la suma de a con el valor absoluto de b
; de ahí el nombre.

; PRUEBAS DE QUE FUNCIONA
(a-plus-abs-b 4 -5) ; tiene que dar 9 y da 9
(a-plus-abs-b 4 5) ; tiene que dar 9 y da 9