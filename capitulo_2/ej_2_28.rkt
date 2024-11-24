#lang racket
;Ejercicio 2.28

(define (fringe tree)
  (define (fringeI tree list)
    (cond ((null? tree)
           list)
          ((pair? (car tree))
           (fringeI (cdr tree) (fringeI (car tree) list)))
          (else
           (fringeI (cdr tree) (cons (car tree) list)))))
  (reverse (fringeI tree '())))





  


(define x 
  (list (list 1 2) (list 3 4)))

(fringe x)
;(1 2 3 4)

(fringe (list x x))
;(1 2 3 4 1 2 3 4)