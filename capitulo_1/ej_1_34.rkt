#lang racket
(define (square x) (* x x))

(define (f g) (g 2))

(f square)
4

(f (lambda (z) (* z (+ z 1))))
6

(f f)

;En vez de desbordar da error porque comprueba antes de ejecutar