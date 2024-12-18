#lang racket
(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        ((iterative-improve good-enough? improve) (improve guess)))))

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (* guess guess) x)) 0.001))
  
  (define (improve guess)
    (/ (+ guess (/ x guess)) 2))
  
  ((iterative-improve good-enough? improve) 1))  ; Empezamos con una estimación inicial de 1

(define (fixed-point f first-guess)
  (define (good-enough? guess)
    (< (abs (- (f guess) guess)) 0.001))
  
  (define (improve guess)
    (f guess))
  
  ((iterative-improve good-enough? improve) first-guess))

(sqrt 9)
;Resultado: Aproximadamente 3.0

(fixed-point cos 1.0)
;Esto debería converger a un valor cercano al punto fijo de coseno, alrededor de 0.739.
