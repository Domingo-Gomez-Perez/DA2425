#lang racket
;Exercise 2.5: Show that we can represent pairs of nonnegative integers using only numbers and arithmetic operations if we represent the pair a and b as the integer
;that is the product 2^a * 3^b. Give the corresponding definitions of the procedures cons, car, and cdr.

(define (cons a b) (* (expt 2 a) (expt 3 b)))
(define (car x) (car-aux x 0))
(define (car-aux x contador) (if (= (remainder x 2) 0) (car-aux (/ x 2) (+ contador 1)) (+ contador 0)))

(define (cdr x) (cdr-aux x 0))
(define (cdr-aux x contador) (if (= (remainder x 3) 0) (car-aux (/ x 3) (+ contador 1)) (+ contador 0)))

(cons 3 4)
(car (cons 3 4))
(cdr (cons 3 4))