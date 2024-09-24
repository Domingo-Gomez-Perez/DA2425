#lang racket


#|
**Exercise 1.46:** Several of the numerical methods
described in this chapter are instances of an extremely general computational
strategy known as "iterative improvement".  Iterative improvement says
that, to compute something, we start with an initial guess for the answer, test
if the guess is good enough, and otherwise improve the guess and continue the
process using the improved guess as the new guess.  Write a procedure
`iterative-improve` that takes two procedures as arguments: a method for
telling whether a guess is good enough and a method for improving a guess.
`Iterative-improve` should return as its value a procedure that takes a
guess as argument and keeps improving the guess until it is good enough.
Rewrite the `sqrt` procedure of section 1.1.7 and the
`fixed-point` procedure of section 1.3.3 in terms of
`iterative-improve`.
|#
;Versión sqrt

(define (good-enough? guess x)
  (< (abs (- x (* guess guess))) 0.001))


(define(improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (* 0.5 (+ x y)))
(define (iterative-improve good-enough? improve)
  (lambda (guess x)
  (if(good-enough? guess x )                   
          guess                               
          ((iterative-improve good-enough? improve) (improve guess x) x))))

(define sqrt
  (iterative-improve good-enough? improve))

(sqrt 1 6)
#|
esto sería como llamar a la función improve  guess x, donde  la función improve se obtiene de l return de (iterative-improve good-enough? improve),
(improve guess x) es el segundo argumento de improve y x es el ultimo

|#



;((iterative-improve good-enough? improve)1 6)


;Versión fixed-point 




(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))



(fixed-point cos 1.0)

