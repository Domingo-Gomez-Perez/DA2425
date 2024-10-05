#lang racket

; Exercise 1.41

; Define a procedure `double` that takes a procedure of one argument 
; as argument and returns a procedure that applies the original procedure twice. 
; For example, if `inc` is a procedure that adds 1 to its argument, 
; then `(double inc)` should be a procedure that adds 2.

(define (double f)
  (lambda (x)
    (f (f x))))

((double (lambda (x) (* x x))) 3) ; ((x^2)^2) -> x = 3 -> 3^4


;  What value is returned by (((double (double double)) inc) 5)  ?

(define (inc x)
  (+ x 1))


(((double (double double)) inc) 5)

; (((double (4 times)) inc) x)
; (((16 times) inc) x)

; Return (((16 times) inc) x) -> (16*1) + 5 = 21
