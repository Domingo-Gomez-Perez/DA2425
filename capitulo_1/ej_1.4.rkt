#lang racket

;Exercise 1.4: Observe that our model of evaluation allows for combinations whose operators are compound expressions. 
;Use this observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;Este procedimiento usa el valor de b para elegir entre sumar o restar.
;Si b es positivo, el operador es + si b es negativo o cero, el operador es -. 
;El procedimiento devuelve la suma de a con el valor absoluto de b.
;De ahí el nombre, "a-plus-abs-b".

; PRUEBAS DE QUE FUNCIONA
(a-plus-abs-b 4 -5) ; tiene que dar 9 y da 9
(a-plus-abs-b 4 5) ; tiene que dar 9 y da 9