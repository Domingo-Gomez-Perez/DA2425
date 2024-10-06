#lang racket

; Hecho por:
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#| 
Exercise 1.46: 
Several of the numerical methods described in this chapter are instances of an extremely general computational strategy known as 
"iterative improvement". Iterative improvement says that, to compute something, we start with an initial guess for the answer, 
test if the guess is good enough, and otherwise improve the guess and continue the process using the improved guess as the new guess.

Write a procedure iterative-improve that takes two procedures as arguments: 
  - a method for telling whether a guess is good enough 
  - a method for improving a guess.

Iterative-improve should return as its value a procedure that takes a guess as an argument and keeps improving the guess until it is good enough.
 Rewrite the sqrt procedure of section 1.1.7 and the fixed-point procedure of section 1.3.3 in terms of iterative-improve.


sqrt procedure of section 1.1.7
(define (square x) (* x x))
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (average x y) 
  (/ (+ x y) 2))
  
(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))

fixed-point procedure of section 1.3.3
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
|#



;procedure iterative-improve:
(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        ((iterative-improve good-enough? improve) (improve guess)))))



;sqrt procedure:
(define (sqrt x)
    (define (square x) (* x x))
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  
  (define (improve guess)
    (define (average x y) 
  (/ (+ x y) 2))
    (average guess (/ x guess)))
  
  ((iterative-improve good-enough? improve) 1.0))


;fixed-point procedure


(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  
  (define (close-enough? guess)
    (< (abs (- guess (f guess))) tolerance))
  
  (define (improve guess)
    (f guess))
  
  ((iterative-improve close-enough? improve) first-guess))
