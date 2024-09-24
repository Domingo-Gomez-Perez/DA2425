#lang racket
; Ejercicio 1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
; Esta función hace que a 'a' siempre se le sume 'b', independientemente del signo que 'b' tubiera antes.