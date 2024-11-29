#lang racket
(define (cons x y) 
  (lambda (m) (m x y)))

(define (car z) 
  (z (lambda (p q) p)))



(car (cons 5 7))
(car (cons 0 -1))
(car (cons -3 10))

(define (cdr z)
  (z (lambda (p q) q)))


(cdr (cons 5 7))
(cdr (cons 0 -1))
(cdr (cons -3 10))