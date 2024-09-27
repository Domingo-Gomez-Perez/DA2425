#lang racket

;Este calculo el valor absoluto entre dos numeros
; Se realiza un if haciendo la suma o resta dependiendo del valor de b
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))