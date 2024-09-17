#lang racket
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;Esta funcion realiza la suma de "a" y "b" si el valor de b es positivo, y realiza la resta
;de "b" sobre "a" si el valor de "b" es negativo. Esto consigue sumar a "a" el valor
;absoluto de "b"