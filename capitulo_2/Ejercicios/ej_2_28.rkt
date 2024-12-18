#lang racket
(define x 
  (list (list 1 2) (list 3 4)))

(define (fringe lista)
  (cond ((null? lista) '())
        ((not (pair? lista)) (list lista))
        (else (append (fringe (car lista))
                      (fringe (cdr lista))))))



(fringe x)
(fringe (list x x))