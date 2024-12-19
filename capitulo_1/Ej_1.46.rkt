#lang racket
(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (if (good-enough? guess)
        guess
        (iter (improve guess))))
  iter)

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (* guess guess) x)) 0.00001))
  
  (define (improve guess)
    (/ (+ guess (/ x guess)) 2))
  
  ((iterative-improve good-enough? improve) 1))

(sqrt 16)