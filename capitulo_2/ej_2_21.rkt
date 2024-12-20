#lang racket





(define (square-list items)
  (if (null? items)
      '()
      (cons (* (car items)(car items)) (square-list (cdr items)))))

(square-list (list 1 2 3 4))
;Tiene que salir (1 4 9 16)


(define (square-list-map items)
  (map (lambda(x)(* x x)) items));MAP hace sobre la lista lo que se pone al principio

  (square-list-map (list 1 2 3 4))
;Tiene que salir (1 4 9 16)