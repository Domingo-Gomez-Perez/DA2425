#lang racket

; Exercise 2.4

; Here is an alternative procedural representation of pairs. For this representation,
; verify that `(car (cons x y))` yields `x` for any objects `x` and `y`.

(define (cons x y) 
  (lambda (m) (m x y)))

(define (car z) 
  (z (lambda (p q) p)))

; The corresponding definition of `cdr` is:

(define (cdr z)
  (z (lambda (p q) q)))

; Verification using the substitution model:
; (cdr (cons x y))
; (cdr (lambda (m) (m x y)))
; (cdr (x y))
; ((lambda (p q) q) x y)
; y


; Tests
(define pair (cons 3 4))

(car pair) ; should return 3
(cdr pair) ; should return 4