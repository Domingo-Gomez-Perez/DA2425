#lang racket

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;Si b es un número positivo se realiza la suma de a y b ya que con el if escoge el operador.
;Si b es negativo o 0 se escoge el operador - y se realiza la resta, como b es negativo si se resta este este actua como la suma de un positivo.
;Esto hace que al valor de a se le sume el absoluto de b.
