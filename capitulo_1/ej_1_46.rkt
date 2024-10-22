#lang racket

(define (iterative-improve good-enough? improve)
  (define (iter aproximacion)
    (if (good-enough? aproximacion)
        aproximacion
        (iter (improve aproximacion))))
  iter)


(define (average x y) (/ (+ x y) 2))

(define (sqrt x)
 (define (good-enough? guess)
   (< (abs (- (* guess guess) x)) 0.001))
  
 (define (improve guess)
  (average guess (/ x guess)))

 ((iterative-improve good-enough? improve) 1.0))

;4.47213595499958

(define (fixed-point f first-guess)
  (define (good-enough? guess)
    (< (abs (- 4.47213595499958(f guess) guess)) 0.00001))
  
  (define (improve guess)
    (f guess))
  
  ((iterative-improve good-enough? improve) first-guess))