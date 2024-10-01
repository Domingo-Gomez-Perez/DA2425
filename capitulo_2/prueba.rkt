#lang racket

(define (cons x y)
    (lambda (f) ( f x y)))

(define (cdr x y) y)
(define (car x y) x)
((cons 1(cons 2(cons 3 null))) car);saca el 1
(((cons 1(cons 2(cons 3 null))) cdr) car);saca el 2
((((cons 1(cons 2(cons 3 null))) cdr) cdr) car);saca el 3
(((((cons 1(cons 2(cons 3 null))) cdr) cdr) cdr) car); saca null
