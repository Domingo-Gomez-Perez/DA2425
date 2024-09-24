#lang racket
;Ejercicio 1.17

(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (fast-mul a b)
  (cond ((= b 0) 0)
        ((even? b) (fast-mul (double a) (halve b)))
        (else (+ a (fast-mul a (- b 1))))))

(fast-mul 4 7)
