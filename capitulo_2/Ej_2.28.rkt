#lang racket
(define x 
  (list (list 1 2) (list 3 4)))

(define (fringe arbol)
  (cond
    ((null? arbol) '())
    ((not (list? arbol)) (list arbol))
    (else
     (append (fringe (car arbol)) (fringe (cdr arbol))
    ))))

(fringe x)