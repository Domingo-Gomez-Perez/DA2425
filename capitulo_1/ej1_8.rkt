#lang racket

(define (cube-root x)
  (cube-iter 1.0 x))

(define (good-enough? guess x)
  (< (abs (- (* guess guess guess) x)) 0.001))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (cube-iter guess x)
  (if (good-enough? guess x)
          guess
          (cube-iter (improve guess x) x)))

;Ejemplo
(cube-root 27);