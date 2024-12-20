#lang racket
; Ejercicio 3.1

; accumulator

(define (make-accumulator x)
    (lambda (y) (+ x y))
  )

; Ejemplo
(define A (make-accumulator 5))

(A 10)
15

(A 10)
25