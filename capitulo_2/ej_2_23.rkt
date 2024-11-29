#lang racket

(define lista1 (list 1 2 3 4 5))

; Uso de for-each para multiplicar por 2 cada elemento de la lista
(for-each (lambda (x) (display (* x 2)) (newline)) lista1)

; Deberia devolver 2 4 6 8 10