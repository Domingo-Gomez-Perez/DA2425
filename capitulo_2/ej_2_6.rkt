#lang racket

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define (suma m n)
  (lambda (f) (lambda (x) ((m f) ((n f) x)))))

(define (inc n) (+ n 1))

((two inc) 0)
((one inc) 0)
(((add-1 two) inc) 0)

(((suma two one) inc) 0)