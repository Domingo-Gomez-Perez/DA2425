#lang racket

(define (square x) (* x x))

(define (square-list1 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items #f)) ;NO RECONOCE NIL

(square-list1 (list 1 2 3 4))

;El cons de la línea 10 coloca el cuadrado a la izquierda y a los resultados pasados a la derecha.
;Esto significa que en la última iteración, la nueva adición estará a la izquierda (primero) y la
;primera adición al final (todo en orden inverso).

(define (square-list2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square 
                     (car things))))))
  (iter items #f)) ;NO RECONOCE NIL

(square-list2 (list 1 2 3 4))

;En este caso el cons sigue el orden correcto. El problema ya no está en la ejecución en si misma,
;sino en la forma que tiene el intérprete de leer listas. Como este solo quita paréntesis cuando
;las pares se encapsulan en los cdr, pero estos se encapsulan en el answer (que está en el car),
;entonces no elimina paréntesis.

