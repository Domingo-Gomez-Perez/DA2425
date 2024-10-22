#lang racket
;Exercise 2.22: Louis Reasoner tries to rewrite the first square-list procedure of Exercise 2.21 so that it evolves an iterative process:
(define (square x) (* x x))


(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items null))
;Unfortunately, defining square-list this way produces the answer list in the reverse order of the one desired. Why?

;Porque al construir la lista se añaden los elementos al inicio de ella, en vez de al final

;Louis then tries to fix his bug by interchanging the arguments to cons:

(define (square-list2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square 
                     (car things))))))
  (iter items null))
;This doesn't work either. Explain.

;El principal problema es que al hacer (cons answer ...) en la primera iteracion, answer es null y en la siguiente iteracion estamos poniendo una lista como primer elemento y
;el cuadrado del siguiente termino como segundo elemento

;Probamos con ejemplos ambos metodos
(square-list (list 1 2 3 4))
(square-list2 (list 1 2 3 4 5))