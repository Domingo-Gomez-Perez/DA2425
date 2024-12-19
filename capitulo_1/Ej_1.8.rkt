#lang racket

(define (cube-iter guess x)
  (if (good-enough? guess x)
          guess
          (cube-iter (improve guess x) x)))

(define (good-enough? x y)
  (display x)
  (< (abs (- (* x x x) y))  0.001)
)


(define (improve x y)
  (/ (+ (/ y (* x x)) (* 2 x) ) 3)

  )


(cube-iter 1 27)