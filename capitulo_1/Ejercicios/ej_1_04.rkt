#lang racket
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; La función recibe dos argumentos a y b, dependiendo si b es mayor a 0 se retorna el
; operador +, si no se retorna el menos para luego hacer a + b o a - b respectivamente.
; Esto es con el objetivo de restar si b es nagativo que sería equivalente a sumar su valor absoluto

(a-plus-abs-b 5 3)

; ((if (> 3 0) + -) 5 3))
; (+ 5 3)
; 8

(a-plus-abs-b 5 -3)

; ((if (> -3 0) + -) 5 -3))
; (- 5 -3)
; 8