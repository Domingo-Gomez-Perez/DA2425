#lang racket
; Ejercicio 1.17

(define (even? n)
  (= (remainder n 2) 0))

(define (double x) (+ x x))

(define (halve x) (
    if (even? x)
       (mitad x 0)
       0
                   ))

(define (mitad a b) (
    cond ((= a b)
          a
          )
          ((> a b)
          (mitad (- a 1) (+ b 1))
          )
          ((< a b)
          (mitad (+ a 1) (- b 1))
          )
                       ))

(define (mult b n)
  (cond ((= n 0) 
         0)
        ((= n 1)
         b)
        ((even? n) 
         (mult (double b) (halve n)))
        (else 
         (+ b (mult b (- n 1))))))
