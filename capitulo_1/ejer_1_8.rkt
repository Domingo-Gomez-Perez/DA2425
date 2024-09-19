#lang racket

(define range 0.01)

(define (cube-root-iter guess x)

  (define (square x) (* x x))

  (define (abs x) (if (< x 0) (- x) x))

  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) range))

  (define (improve x y)
    (/ (+ (/ x (square y)) (* 2 y)) 3))
  
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x) x)))

(cube-root-iter 1 2)