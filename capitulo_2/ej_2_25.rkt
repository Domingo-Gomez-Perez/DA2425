#lang racket

; Lista 1
(define lista1 (list 1 3 (list 5 7) 9))

; Combinacion de car y cdr
(cadr (car (cddr lista1)))

; --------------------------------------------------------------------

; Lista 2
(define lista2 (list (list 7)))

; Combinacion de car y cdr
(car (car lista2))

; --------------------------------------------------------------------

; Lista 3
(define lista3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

; Combinacion de car y cdr
(cadr (cadr (cadr (cadr (cadr (cadr lista3))))))