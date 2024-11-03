#lang racket
; Ejercicio 1.41

(define (double proc) (
    lambda (x) (proc (proc x))
                           ))

(define (inc x) (+ x 1))

((double inc) 5)
; Devuelve 7 porque es 5 + 2

(((double (double double)) inc) 5)
