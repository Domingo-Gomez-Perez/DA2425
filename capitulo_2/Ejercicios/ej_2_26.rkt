#lang racket
(define x (list 1 2 3))
(define y (list 4 5 6))
(append x y)
; El append añade cada elemento de la segunda lista al final de la primera lista
(cons x y)
; El cons añade la primera lista al principio de la segunda lista, es decir, crea una lista de pares
(list x y)
; El list crea una lista formada por las dos listas pasadas como argumentos