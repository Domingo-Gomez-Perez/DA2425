#lang racket

(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y) ; Devuelve una sola lista uniendo las dos listas anteriores
(cons x y) ; Devuelve una pareja de listas, en un lado la lista x y en el otro la lista y
(list x y) ; Devuelve una lista donde los elementos son la lista x y la lista y (es decir, una lista de listas)