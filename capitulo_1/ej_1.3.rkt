#lang racket

;Exercise 1.3: Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.
(define (SumaSquare x y) (+ (* x x) (* y y)))

(define (cuadrados x y z ) (if (> x y) 
                                (if (> y z)
                                (SumaSquare x y)
                                (SumaSquare x z)
                                )
                                (if (> x z) 
                                (SumaSquare x y)
                                (SumaSquare y z))))

(cuadrados 2 3 4) ;tiene que dar 25 y da 25
(cuadrados 2 2 2) ;tiene que dar 8 y da 8
(cuadrados 4 7 9) ;tiene que dar 130 y da 130