#lang racket
(define (square x)
  (* x x))

; Louis Reasoner tries to rewrite the first square-list procedure of Exercise 2.21 so that it evolves an iterative process:
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items null))

(square-list (list 1 2 3 4)) ; -> '(16 9 4 1)
; Unfortunately, defining square-list this way produces the answer list in the reverse order of the one desired. Why?
; Louis produce la lista en orden inverso porque está agregando el resultado del cuadrado de cada
; elemento al principio de la lista acumulada answer, usando cons. Así, los elementos se acumulan en orden inverso al original.

; Louis then tries to fix his bug by interchanging the arguments to cons:
(define (square-list-2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square 
                     (car things))))))
  (iter items null))

(square-list-2 (list 1 2 3 4)) ; -> '((((() . 1) . 4) . 9) . 16)
; This doesn't work either. Explain.
; No funciona porque cons espera que el primer argumento sea el nuevo elemento a agregar y el segundo argumento sea la lista acumulada.
; Al intercambiar los argumentos, Louis coloca answer (una lista) en la primera posición y el cuadrado del elemento (un número) en la segunda,
; generando una lista de listas.
; Dicho de otra forma, a la nueva lista añadimos la anterior (answer):
;  1. a la lista (1), añadimos answer (), generando (() . 1)
;  2. a la lista (4), añadimos answer (() . 1), generando ((() . 1) . 4)
;  3. a la lista (9), añadimos answer ((() . 1) . 4), generando (((() . 1) . 4) . 9)
; Y así, sucesivamente...
