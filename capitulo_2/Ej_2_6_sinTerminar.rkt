#lang racket
; Ejercicio 2.6

(define zero (lambda (f) (lambda (x) x)))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

; n=two, f=inc, x=0
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define (add n m) (
    (lambda (f) (lambda (x) (f ((n (m f)) x)))))
                   )

(define (inc x) (+ x 1))

(((add-1 zero) inc) 0)
; (((lambda (f) (lambda (x) (f ((zero f) x)))) inc) 0)
; (((lambda (f) (lambda (x) (f (((lambda (g) (lambda (y) y)) f) x)))) inc) 0)
; ((lambda (x) (inc (((lambda (g) (lambda (y) y)) inc) x))) 0)
; ((lambda (x) (inc (((lambda (y) y)) x))) 0)
; ((lambda (x) (inc x)) 0)
; ((lambda (x) (inc x)) 0)
; (inc 0)
; 1

(((add-1 one) inc) 0)
(((add-1 two) inc) 0)

(((add one two) inc) 0)