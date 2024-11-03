#lang racket

; Exercise 1.42

; Let `f` and `g` be two one-argument functions. The composition `f` after `g` is 
; defined to be the function that maps `x` to `f(g(x))`. Define a procedure `compose` 
; that implements composition. For example, if `inc` is a procedure that adds 1 to its argument,

; Auxiliar functions:

(define (square x)
  (* x x))

(define (inc x)
  (+ x 1))


; Solution:

(define (compose f g)
  (lambda (x)
    (f (g x))))


((compose square inc) 6) ; -> ((6+1)^2) = 49