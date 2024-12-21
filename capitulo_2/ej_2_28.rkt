#lang racket


(define x 
  (list (list 1 2) (list 3 4)))

(define (fringe lista)
  (if (null? lista)
      '()
    (append (if (pair? (car lista))
               (fringe (car lista))
               (list (car lista)))
            (fringe (cdr lista)))))
    

(fringe x)

(fringe (list x x))