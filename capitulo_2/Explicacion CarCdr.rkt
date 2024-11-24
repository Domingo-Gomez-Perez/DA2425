#lang racket

(define (cons x y)
  (lambda (f) (f x y)))

;(define (car f)
  ;(f(lambda (x y) x)))

(define (cdr x y) y)
(define (car x y) x)
((cons 1 (cons 2 (cons 3 null))) car)
(((cons 1 (cons 2 (cons 3 null)))cdr) car)

;((cons 1 2) z)

;((lamnda (f) (f 1 2)) z)

;(z 12)
;(+ 1 2)
;3