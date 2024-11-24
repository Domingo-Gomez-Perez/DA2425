#lang racket


(define (fringe tree)
  (cond ((null? tree) '())  
        ((not (list? (car tree))) (cons (car tree) (fringe (cdr tree)))) 
        (else (append (fringe (car tree)) (fringe (cdr tree))))))  


(define x (list (list 1 2) (list 3 4)))
(display "Fringe of x: ")
(display (fringe x))  ;;(1 2 3 4)
(newline)


(define y (list x x))  
(display "Fringe of y: ")
(display (fringe y))  ;;(1 2 3 4 1 2 3 4)
(newline)

