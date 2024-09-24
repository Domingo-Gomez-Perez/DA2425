#lang racket
;Ejercicio 1.41

(define (inc x) (+ x 1))

(define (double proc )
  (lambda (x)
    (proc (proc x))))

((double inc)5)
;(5 + (inc * 2)) = 7

(((double double) inc) 5)
;(5 + ((inc * 2)* 2)) = 9

(((double (double double)) inc) 5)

;(5 + 2 ^ ((inc * 2)* 2)) = 21