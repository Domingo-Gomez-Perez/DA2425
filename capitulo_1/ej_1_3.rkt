#lang racket
;Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.
(define (square x) (* x x))

(define (ej1_3 x y z) (cond ((and (or (> x y) (= x y)) (or (> x z) (= x z))) (if (or (> y z) (= y z)) (+ (square x) (square y)) (+ (square x) (square z))))                                             
                             ((and (or (> y z) (= y z)) (or (> y x) (= y x))) (if (or (> x z) (= x z)) (+ (square y) (square x)) (+ (square y) (square z))))
                             (else (if (or (> x y) (= x y)) (+ (square z) (square x)) (+ (square z) (square y))))))
