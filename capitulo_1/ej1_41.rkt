#lang racket

; **Exercise 1.41:** Define a procedure `double`
; that takes a procedure of one argument as argument and returns a procedure that
; applies the original procedure twice.  For example, if `inc` is a
; procedure that adds 1 to its argument, then `(double inc)` should be a
; procedure that adds 2.  What value is returned by

; ```
; (((double (double double)) inc) 5)
; ```

(define (double f)
  (lambda (x)
    (f (f x))))

(define (inc x)
  (+ x 1))

; (double inc) será una función que incrementa dos veces.
((double inc) 5)
; Resultado: 7 (incrementa 5 dos veces: 5 + 1 + 1 = 7)
((double inc) 8)
; Resultado: 10 (incrementa 5 dos veces: 5 + 1 + 1 = 7)
