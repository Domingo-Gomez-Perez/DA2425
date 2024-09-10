#lang racket
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
; El procedimiento le suma el valor absoluto de "b" a "a", ya que si
; "b" es mayor que cero el procedimiento será "(+ a b)", pero si
; "b" es menor que cero el procedimiento será "(- a b)", pasando a
; valor positivo el signo de "b".