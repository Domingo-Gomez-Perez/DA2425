#lang racket
; Ejercicio 1.16

(define (even? n)
  (= (remainder n 2) 0))

(define (square x) (* x x))

(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))

(define (expt-iter b n) (
    expt b n 1
                         ))

(define (expt b n p) (
    if (= n 1)
       p
       (expt b (- n 1) (* b p))
                      ))