#lang racket
;Several of the numerical methods described in this chapter are instances of an extremely general computational strategy known as "iterative improvement".
;Iterative improvement says that, to compute something, we start with an initial guess for the answer,
;test if the guess is good enough, and otherwise improve the guess and continue the process using the improved guess as the new guess.
;Write a procedure iterative-improve that takes two procedures as arguments: a method for telling whether a guess is good enough and a method for improving a guess.
;Iterative-improve should return as its value a procedure that takes a guess as argument and keeps improving the guess until it is good enough.
;Rewrite the sqrt procedure of section 1.1.7 and the fixed-point procedure of section 1.3.3 in terms of iterative-improve.

;Funciones good-enough y improve de la seccion 1.1.7
;(define (good-enough? guess x)
;  (< (abs (- (square guess) x)) 0.001))

;(define (improve guess x)
;  (average guess (/ x guess)))

;Funcion sqrt de seccion 1.1.7

;(define (sqrt-iter guess x)
;  (if (good-enough? guess x)
;      guess
;      (sqrt-iter (improve guess x) x)))

;Funcion fixed-point de la seccion 1.3.3
; (define tolerance 0.00001)

;(define (fixed-point f first-guess)
;  (define (close-enough? v1 v2)
;    (< (abs (- v1 v2)) 
;       tolerance))
;  (define (try guess)
;    (let ((next (f guess)))
;      (if (close-enough? guess next)
;          next
;          (try next))))
;  (try first-guess))

;(define (close-enough? x y) 
;  (< (abs (- x y)) 0.001))


;======================================

(define (square x) (* x x))

(define (average x y) (/ (+ x y) 2))

(define (iterative-improve good-enough? improve)
  (define (bucleiterative guess x funct)
    (if (good-enough? guess x funct)
         guess
         (bucleiterative (improve guess x funct) x funct))
    )
  (lambda (guess x funct)
    (bucleiterative guess x funct))
  )

(define (good-enough? guess x funct)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x funct)
  (average guess (/ x guess)))

(define (sqrt x) ((iterative-improve good-enough? improve) 1.0 x null))

(sqrt 100)

;PARA EL FIXED POINT

(define tolerance 0.00001)

(define (close-enough? v1 x funct)
    (< (abs (- v1 (funct v1))) 
      tolerance))

(define (improve2 guess x funct) (funct guess))


(define (fixed-point funct guess) ((iterative-improve close-enough? improve2) guess null funct))

(fixed-point sqrt 8)
