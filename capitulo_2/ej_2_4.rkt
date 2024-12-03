#lang racket

(define (cons2 x y) ; Definicion alternativa de cons
  (lambda (m) (m x y)))

(define (car2 z) ; Definicion alternativa de car
  (z (lambda (p q) p)))

(define (cdr2 z) ; Definicion alternativa de cdr
  (z (lambda (p q) q)))

; Demostracion
(define pareja1 (cons2 2 6))

(car2 pareja1)

(cdr2 pareja1)

; Observamos que si que funciona esta definicion alternativa para los tres metodos: cons, car y cdr