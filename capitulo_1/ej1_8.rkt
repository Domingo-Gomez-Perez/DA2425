#lang racket
(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (crt-iter guess x)
  (if (good-enough? guess x)
      guess
      (crt-iter (improve guess x) x)))

(define (crt x)
  (crt-iter 2.5 x))

(crt 27)




