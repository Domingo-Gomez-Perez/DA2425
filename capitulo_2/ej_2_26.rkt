#lang racket


;Suppose we define x and y to be two lists:
(define x (list 1 2 3))
(define y (list 4 5 6))

;What result is printed by the interpreter in response to evaluating
;each of the following expressions:
(append x y) ;Este printa una lista entera con los valores de las dos listas
(cons x y) ;La lista x es añadida a la lista y como si fuera el primer elemento
(list x y) ;Es una lista en la cual el primer elemmento es x y el segundo seria todo y