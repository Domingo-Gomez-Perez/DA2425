#lang racket
;Ejercicio 2.6

(define (numer r) (car r))  
(define (denom r) (cdr r))

(define (make-rat numer denom)
  (if (< (* numer denom) 0)
      (cons (- (abs numer)) (abs denom))
      (cons (abs numer) (abs denom))))


(define a (make-rat 2 -7))   
(define b (make-rat -8 -6))

(numer a)   
(denom a)   

(numer b)  
(denom b)   
