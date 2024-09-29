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
;Versión sqrt con el uso de iterative-improve

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

;Otra versión sqrt con el uso de iterative-improve


(define (iterative-improve-sqrt good-enough? improve)
  (define (iter guess x)
   
  (if(good-enough? guess x )                   
          guess                               
          ((iterative-improve-sqrt good-enough? improve) (improve guess x) x)))
 (lambda (guess x)
  (iter guess x)))


((iterative-improve-sqrt good-enough? improve)1 6)

#|
((iterative-improve-sqrt good-enough? improve) (improve guess x) x))
(iterative-improve-sqrt good-enough? improve) devuelve una función que toma como argumentos x y el resultado de (improve guess x) 

|#

((iterative-improve good-enough? improve)1 6)



(define tolerance 0.00001)
(define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))


    
;Version recursiva fixed-point
(define (fixed-point f first-guess)
      (let ((next (improve2 first-guess f)))
      (if (close-enough? first-guess next)
          next
          (fixed-point f next))))

(define(improve2 guess f)
(f guess))

(fixed-point cos 1.0)

;Versión recursiva fixed-poind con el uso de iterative-improve


(define (iterative-improve-fixed close-enough?2 improve2)
  (lambda (guess f)
    (let ((next (improve2 guess f)))
      (if (close-enough? guess next)
          next
          ((iterative-improve-fixed close-enough? improve2) next f)))))

((iterative-improve-fixed close-enough? improve2)1.0 cos)

;Otra versión fixed-point con el uso de iterative-improve

(define (iterative-improve-fixed2 close-enough?2 improve2)
  (define (iter2 guess f)
    (let ((next (improve2 guess f)))
      (if (close-enough? guess next)
          next
          (iter2 next f))))
(lambda (guess f)
(iter2 guess f)))

#|Otra forma:
(define (iter guess f)
    (let ((next (improve2 guess f)))
      (if (close-enough? guess next)
          next
          (iter next f))))


(define (iterative-improve-fixed2 close-enough?2 improve2)
  (lambda (guess f)
  (iter guess f)))
|#

((iterative-improve-fixed2 close-enough? improve2)1.0 cos)