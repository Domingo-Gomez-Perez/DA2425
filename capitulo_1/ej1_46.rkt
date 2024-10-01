#lang racket

; **Exercise 1.46:** Several of the numerical methods
; described in this chapter are instances of an extremely general computational
; strategy known as "iterative improvement".  Iterative improvement says
; that, to compute something, we start with an initial guess for the answer, test
; if the guess is good enough, and otherwise improve the guess and continue the
; process using the improved guess as the new guess.  Write a procedure
; `iterative-improve` that takes two procedures as arguments: a method for
; telling whether a guess is good enough and a method for improving a guess.
; `Iterative-improve` should return as its value a procedure that takes a
; guess as argument and keeps improving the guess until it is good enough.
; Rewrite the `sqrt` procedure of section 1.1.7 and the
; `fixed-point` procedure of section 1.3.3 in terms of
; `iterative-improve`.

(define (iterative-improve good-enough? improve)
  (define (try guess)
    (if (good-enough? guess)
        guess
        (try (improve guess))))
  try)

; Reescribir sqrt usando iterative-improve
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (* guess guess) x)) 0.001))
  (define (improve guess)
    (/ (+ guess (/ x guess)) 2))
  ((iterative-improve good-enough? improve) 1.0))

; Reescribir fixed-point usando iterative-improve
(define (fixed-point f)
  (define (good-enough? guess)
    (< (abs (- (f guess) guess)) 0.001))
  (define (improve guess)
    (f guess))
  ((iterative-improve good-enough? improve) 1.0))

(sqrt 16)           ; Resultado esperado: Aproximadamente 4
(fixed-point cos)    ; Resultado esperado: Aproximadamente 0.739

;COMPROBADO VVVV
