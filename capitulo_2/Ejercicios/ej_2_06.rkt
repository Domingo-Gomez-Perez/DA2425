#lang racket
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define (incremento x)
  (+ x 1))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(((add-1 (add-1 one)) incremento) 0)

(((add-1 (add-1 two)) incremento) 0)