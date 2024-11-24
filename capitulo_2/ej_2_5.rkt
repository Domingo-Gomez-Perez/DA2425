#lang racket
;Ejercicio 2.5

(define (cons a b)(* (expt 2 a) (expt 3 b)))

(define (div-cont n num) 
  (if (= (modulo n num) 0)
      (+ 1 (div-cont (/ n num) num))
      0))

(define (car x)(div-cont x 2))    
(define (cdr x)(div-cont x 3))   

(define a (cons 5 6))
(car a)
(cdr a)
