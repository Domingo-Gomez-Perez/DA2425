#lang racket
;Ejercicio 1.46

;Iterarive-improve

(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        ((iterative-improve good-enough? improve) (improve guess)))))

;sqrt (iterative-improve)

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (* guess guess) x)) 0.0001)) 
  
  (define (improve guess)
    (average guess (/ x guess)))

  ((iterative-improve good-enough? improve) 1.0))  

;fixed-point (iterative-improve)

(define (fixed-point f first-guess)
  (define (good-enough? guess)
    (< (abs (- (f guess) guess)) 0.0001))
  
  (define (improve guess)
    (f guess))  

  ((iterative-improve good-enough? improve) first-guess)) 
