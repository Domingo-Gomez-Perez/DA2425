#lang racket
(define (square x) (* x x))

(define (f g) (g 2))

(f square)
4

(f (lambda (z) (* z (+ z 1))))
6

(f f)

;Debería haber una llamada recursiva infinita con desbordamiento de cola. Esto se debe a que, tras
;la sustitución, la llamada de f solo conduce a sucesivas llamadas de f. En vez de eso da error previo.