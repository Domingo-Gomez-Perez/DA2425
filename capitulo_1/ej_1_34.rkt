#lang racket


(define (f g) (g 2))

(define (square x)(* x x))

(f square)


(f (lambda (z) (* z (+ z 1))))

;Este proceso falla puesto que g tiene que ser una funcion y
; tu le estas dando f el cual da (g 2) y por lo tanto no hay ninguna funcion
(f f)