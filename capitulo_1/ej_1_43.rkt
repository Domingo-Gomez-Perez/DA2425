#lang racket
;If f is a numerical function and n is a positive integer, then we can form the nth repeated application of f,
;which is defined to be the function whose value at x is f(f(...(f(x)))). For example, if f is the function that maps x to x+1,
;then the nth repeated application of f is the function that maps x to x+n. If f is the operation of squaring a number,
;then the nth repeated application of f is the function that raises its argument to the 2^n power.
;Write a procedure that takes as inputs a procedure that computes f and a positive integer n and returns the procedure that computes the nth repeated application of f.
;Your procedure should be able to be used as follows:

(define (square x) (* x x))

;((repeated square 2) 5)    ;-> 625
;Hint: You may find it convenient to use compose from Exercise 1.42.
(define (compose f g) (lambda (x) (f (g x))))

;Si n = 1 se acaba la recursion y se devuelve lo acumulado
(define (repeated f n) (if (= 1 n) f (compose f (repeated f (- n 1)))))  ; De otra forma, se vuelve a la recursion



; Probamos el ejemplo dado en el enunciado
((repeated square 2) 5)

