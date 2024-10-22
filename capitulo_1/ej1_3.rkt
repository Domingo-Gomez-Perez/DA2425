#lang racket

;Define a procedure that takes three numbers as
;arguments and returns the sum of the squares of the two larger
;numbers.


(define (sum-of-squares-of-largest a b c)
  (define (square x) (* x x))  ; Define una función para obtener el cuadrado de un número
  (cond
    [(and (<= a b) (<= a c)) (+ (square b) (square c))]  ; Si "a" es el menor, suma los cuadrados de "b" y "c"
    [(and (<= b a) (<= b c)) (+ (square a) (square c))]  ; Si "b" es el menor, suma los cuadrados de "a" y "c"
    [else (+ (square a) (square b))]))  ; Si "c" es el menor, suma los cuadrados de "a" y "b"

(sum-of-squares-of-largest 1 2 3)
