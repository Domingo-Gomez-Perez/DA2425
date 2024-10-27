#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.28: Write a procedure fringe that takes as argument a tree (represented  as a list) and returns a list whose elements are all the leaves of the tree arranged
in left-to-right order. For example,

(define x
  (list (list 1 2) (list 3 4)))

(fringe x)
; => (1 2 3 4)

(fringe (list x x))
; => (1 2 3 4 1 2 3 4)
|#

; es decir, recorre el arbol en postorder

(define (fringe lista)
  (cond ((null? lista)
         null)  ;; Si el árbol es vacío, retorna una lista vacía
        ((pair? lista)       ;; Si es un par (es decir, una lista), procesar recursivamente
         (append (fringe (car lista)) (fringe (cdr lista)))) ; procesamos las dos partes del par
        (else
         (list lista)))) ;; Si no es un par, es una hoja, así que la devuelve como lista

; pruebas
(define x
  (list (list 1 2) (list 3 4)))

(define y
  (list (list 1)))

(define z
  (list (list 1 2)))

(define a
  (list (list)))

(define b
  (list 1 2))

(define c
  (list (list 3 4) 1 2))


x
(fringe x)
; => (1 2 3 4)

(fringe y)
; => (1)

(fringe z)
; => (1 2)

(fringe a)
; => ()

(fringe b)

(fringe c)
