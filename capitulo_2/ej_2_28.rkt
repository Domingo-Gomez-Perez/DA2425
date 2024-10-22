#lang racket
;Exercise 2.28: Write a procedure fringe that takes as argument a tree (represented as a list) and returns a list
;whose elements are all the leaves of the tree arranged in left-to-right order. For example,

(define x 
  (list (list 1 2) (list 3 4)))

(define (fringe-aux lista resultado) 
         (cond
           ((null? lista) resultado)
           ((list? (car lista)) ;Si es una lista no es hoja y se debe recorrer
                   (fringe-aux (cdr lista) (fringe-aux (car lista) resultado))) ;Hago una llamada recursiva donde recorrere derecha, pero antes izquierda
           (else (fringe-aux (cdr lista) (append resultado (list (car lista)))))) ;Si es hoja, añado izquierda a resultado y recorro derecha
 
 )

(define (fringe lista) (fringe-aux lista null))


(fringe x)
;(1 2 3 4)

(fringe (list x x))
;(1 2 3 4 1 2 3 4)