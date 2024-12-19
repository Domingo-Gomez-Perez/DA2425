#lang racket
; Primera lista
(define lista1 (list 1 3 (list 5 7) 9))
(car(cdr (car (cdr (cdr lista1)))))



; Segunda lista
(define lista2 (list(list 7)))
(car (car lista2))

; Tercera lista
(define lista3 (list 1 (list 2 (list 3 (list 4 (list 5 (list  6 7)))))))
(car(cdr(car(cdr(car(cdr(car(cdr(car(cdr(car (cdr lista3))))))))))))


