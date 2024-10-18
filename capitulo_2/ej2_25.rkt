#lang racket

(define lista1 (list 1 3 (list 5 7) 9))
(display (car (cdr (car (cdr (cdr lista1))))))
(newline)

(define lista2 (list (list 7)))
(display (car (car lista2)))
(newline)

(define lista3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(display (car (cdr (cdr (car (cdr (cdr (car (cdr (cdr (car (cdr lista3))))))))))))
(newline)

