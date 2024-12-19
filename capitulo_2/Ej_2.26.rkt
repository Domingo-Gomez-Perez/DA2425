#lang racket
(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y)
; Concatena la lista y a la x, en el proceso elimina el null de terminación de x y solo deja el de y.
; El resultado por tanto es el siguiente: '(1 2 3 4 5 6)

(cons x y)
; Une la y al final de x pero no elimina el null de x por lo que x queda como una lista en y.
; El resultado es '((1 2 3) 4 5 6) 

(list x y)
; Crea una nueva lista en la que x e y son sus elementos además añade un null nuevo de terminación.
; El resultado es '((1 2 3) (4 5 6))