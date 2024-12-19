#lang racket
(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (* guess guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) 
  (/ (+ x y) 2))

(sqrt-iter 1.0 2)

; Lo que sucede aquí es que se queda sin memoria debido a un bucle infinito
; Este bucle sucede porque la clausula new-if usa el orden aplicativo, por lo
; que aunque la primera condición se cumpla, comprueba la segunda condición y
; es por ello que en sqrt-iter donde se da el bucle infinito en lugar de tomar
; la primera opción del if que se cumple como hace el if normal.