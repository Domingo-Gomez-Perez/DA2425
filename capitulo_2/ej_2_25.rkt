#lang racket
;Exercise 2.25: Give combinations of cars and cdrs that will pick 7 from each of the following lists:

;(1 3 (5 7) 9)
(define lista1 (cons 1 (cons 3 (cons (cons 5 7) 9))))
(cdr (car (cdr (cdr lista1))))

;((7))
(define lista2 (list (list 7)))
(car (car lista2)) ;Al estar el 7 solo en 2 listas serian necesarios 2 operaciones car o cdr cualesquiera

;(1 (2 (3 (4 (5 (6 7))))))
(define lista3 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 (cons 6 7)))))))
(cdr (cdr (cdr (cdr (cdr (cdr lista3))))))