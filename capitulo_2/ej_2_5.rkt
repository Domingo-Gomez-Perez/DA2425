#lang racket

;Definicion de cons
(define (cons x y) 
  (* (expt 2 x)(expt 3 y)))

;modulo es el resto

;Definicion de car, se debe de devolver el valor x 
(define (car n)
  (define (count-factors n divisor)
    (if (= (modulo n divisor) 0)
        (+ 1 (count-factors (/ n divisor) divisor))
        0))
  (count-factors n 2))

;Definicion de cdr, se debe de devolver el valor y 
(define (cdr n)
  (define (count-factors n divisor)
    (if (= (modulo n divisor) 0)
        (+ 1 (count-factors (/ n divisor) divisor))
        0))
  (count-factors n 3))


(cons 3 4)
(car (cons 3 4))
(cdr (cons 3 4))