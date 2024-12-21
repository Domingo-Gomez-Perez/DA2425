#lang racket
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define (plus m n)
  (lambda (f) (lambda (x) ((m f) ((n f) x)))))

(define (inc n) (+ n 1))
(define (ninc n) (- n 1))

((two inc) 0)
((one inc) 0)
(((add-1 two) inc) 0)

(((plus two one) inc) 0)

; Returns a procedure representing x - y
(define (sub x y)
  (lambda (f g) (lambda (z) ((x f) ((y g) z)))))

(displayln "Sub:")
(((sub two one) inc ninc) 0)
(((sub (plus two one) one) inc ninc) 0)