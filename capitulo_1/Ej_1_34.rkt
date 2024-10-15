#lang racket
; Ejercicio 1.34

(define (square x) (* x x))

(define (f g) (g 2))

(f square)

(f (lambda (z) (* z (+ z 1))))

(f f)

; application: not a procedure;
; expected a procedure that can be applied to arguments
;  given: 2

; El procedimiento f recive un procedimiento como parámetro, pero a ese procedimiento
; luego se le pasa un número, como ese procedimiento vuelve a ser f, el interprete se
; queja porque f no puede recivir un número como parámetro.