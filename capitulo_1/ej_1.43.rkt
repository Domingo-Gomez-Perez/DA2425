#lang racket

; Hecho por:
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Exercise 1.43:
If f is a numerical function and n is a positive integer, then we can form the nth repeated
 application of f, which is defined to be the function whose value at x is f(f(...(f(x)))).

For example:
- If f is the function that maps x to x + 1, then the nth repeated application of f is the 
    function that maps x to x + n.
- If f is the operation of squaring a number, then the nth repeated application of f is 
    the function that raises its argument to the 2^n power.

Write a procedure that takes as inputs a procedure that computes f and a positive 
integer n, and returns the procedure that computes the nth repeated application of f.
 Your procedure should be able to be used as follows:

((repeated square 2) 5)    ; -> 625
|#

(define (repeated f n)
  (if (= n 1)
      f
      (lambda (x) ((repeated f (- n 1)) (f x)))))

(define (square x) (* x x))

; Ejemplo de uso
((repeated square 2) 5)
