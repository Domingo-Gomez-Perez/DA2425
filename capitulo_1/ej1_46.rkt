#lang racket
(define tolerance 0.0001)

; iterative-improve
(define (iterative-improve good-enough? improve)
  (define (iter guess x)
      (if (good-enough? guess x)
          guess
          (iter (improve guess x) x)))
  (lambda (guess x) (iter guess x)))

; sqrt en función de iterative-improve
(define (sqrt x)
  (define (good-enough? guess x)
    (define (square x)
      (* x x))
    (< (abs (- (square guess) x)) tolerance))
  (define (improve guess x)
    (define (average x y) 
      (/ (+ x y) 2))
    (average guess (/ x guess)))
  ((iterative-improve good-enough? improve) 1.0 x))

; fixed-point en función de iterative-improve
(define (fixed-point f first-guess)
  (define (good-enough? guess _)
    (< (abs (- guess (f guess))) tolerance))
  (define (improve guess _)
    (f guess))
  ((iterative-improve good-enough? improve) first-guess null))

; comprobar
(sqrt 2)
(fixed-point cos 1.0)
