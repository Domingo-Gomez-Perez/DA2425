#lang racket

(define (make-accumulator acum)
  (define (ingresar x)
    (set! acum (+ acum x))
    acum) 
  ingresar) 


(define A (make-accumulator 5))

(displayln (A 10)) 
(displayln (A 10)) 
