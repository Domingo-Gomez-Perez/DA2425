#lang racket

(define (iterative-improve good-enough? improve)
  (define (iter loop-guess)
    (if (good-enough? loop-guess)
        loop-guess
        (iter (improve loop-guess))))
  iter)

(define (sqrt1 x)
  (define (good-enough? guess)
    (< (abs (- (* guess guess) x)) 0.001))

  (define (improve guess)
    (/ (+ guess (/ x guess)) 2))  

  ((iterative-improve good-enough? improve) 1.0)) 


(define (fixed-point f first-guess)
  (define (good-enough? guess)
    (< (abs (- (f guess) guess)) 0.001))

  (define (improve guess)
    (f guess)) 

  ((iterative-improve good-enough? improve) first-guess))

(define (square x)
  (* x x))

(define (suma x)
  (+ x x))