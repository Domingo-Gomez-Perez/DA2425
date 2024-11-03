#lang racket
;Suppose we define the procedure

;(define (f g) (g 2))
;Then we have
;(f square)
;4
;(f (lambda (z) (* z (+ z 1))))
;6
;What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? Explain.

(define (f g) (g 2))

(define (square x) (* x x))

(f square)

(f (lambda (z) (* z (+ z 1))))

(f f)
;No se puede ejecutar debido a que f espera como argumento un numero, no un procedimiento, al hacer (f f)
;Esto pasa a ser (f 2), al f necesitar un número no un procedimiento, da error.