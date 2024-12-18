#lang racket
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (sqr (car things))
                    answer))))
  (iter items null))

; (iter (cdr (1 2 3 4)(cons (sqr (car 1 2 3 4)) null))
; (iter (2 3 4)(cons 1 null))
; (iter (3 4)(cons (sqr (car 2 3 4)) (1)))
; (iter (3 4)(cons 4 (1)))
; (iter (4)(cons 9 (4 1)))
; (16 9 4 1))

(define (square-list2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (sqr 
                     (car things))))))
  (iter items null))

; Esto pasa porque answer al principio es una lista vacía por lo que al hacer un cons se crea una nueva lista que contiene todas las listas anteriores y el cuadrado lo que da este
; este resultado extraño

(square-list (list 1 2 3 4))
(square-list2 (list 1 2 3 4))