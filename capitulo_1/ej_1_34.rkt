#lang racket
;Ejercuicio 1.34
(define (f g) (g 2))

(define (square x) (* x x))

(f square)


(f (lambda (z) (* z (+ z 1))))

(f f)

;La llamada (f f) lleva a una recursion infinita, ya que dentro de f
; se intente ejecutar (g 2) que es (f 2)