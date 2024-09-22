#lang racket
(define (cubo_root x)
  (cubo-root-iter 1.0 x))

(define (cubo-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cubo-root-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (* guess guess guess) x)) 0.001))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(cubo_root 27)

; El funcionamiento es prácticamente el mismo al del 1.6 si se usa if en lugar de new-if,
; pero usando la fórmula de la raiz cúbica en vez de