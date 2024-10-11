#lang racket
(define (cube-root guess x)
  (if (good-enough? guess x)
      guess
      (cube-root (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (* guess guess guess) x)) 0.001))  ; Comprobamos si guess^3 se acerca a x

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))  ; Usamos la formula de Newton

(cube-root 1.0 8)

