#lang racket

; Exercise 1.46

; Several of the numerical methods described in this chapter are instances of an extremely general 
; computational strategy known as "iterative improvement". Iterative improvement says that, to compute 
; something, we start with an initial guess for the answer, test if the guess is good enough, and otherwise 
; improve the guess and continue the process using the improved guess as the new guess. 

; Write a procedure `iterative-improve` that takes two procedures as arguments: a method for telling whether 
; a guess is good enough and a method for improving a guess. `Iterative-improve` should return as its value a
; procedure that takes a guess as argument and keeps improving the guess until it is good enough. Rewrite the 
; `sqrt` procedure of section 1.1.7 and the `fixed-point` procedure of section 1.3.3 in terms of `iterative-improve`.

; Gereric iterative-improve fucntion

(define (iterative-improve f-good-enough? f-improve)
  (define (f guess x function)
    (if (f-good-enough? guess x function)
        guess
        (f (f-improve guess x function) x function)))

  (lambda (guess x function)
    (f guess x function)))


; Rewrite of sqrt

(define (good-enough-sqrt? guess x _)
	(< (/ (abs (- (* guess guess) x)) guess) 0.001))

(define (improve-sqrt guess x _)
  (/ (+ guess (/ x guess)) 2))


(define (sqrt x)
  ((iterative-improve good-enough-sqrt? improve-sqrt) 1.0 x null))


(sqrt 81) ; -> 9.000...


; Rewrite of fixed-point

(define (good-enough-fixed-point? guess _ g)
  (< (/ (abs (- guess (g guess))) guess) 0.0005))

(define (improve-fixed-point guess _ g)
  (g guess))


(define (fixed-point g guess)
  ((iterative-improve good-enough-fixed-point? improve-fixed-point) guess null g))


(fixed-point sqrt 5.0) ; -> 1
