#lang racket
;Ejercicio 2.22

(define (square x) (* x x))

;Iterativo
(define (square-listI items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items null))

(square-listI (list 1 2 3 4))
;La lista resultante se forma al revés porque los elementos
;se insertan en la parte delantera de la lista acumulada.


;Intercambiado
(define (square-listII items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square 
                     (car things))))))
  (iter items null))

(square-listII (list 1 2 3 4))
;La sintaxis de cons es incorrecta, ya que trata de colocar
;la lista acumulada como el primer argumento,
;lo que no tiene sentido y produce una estructura errónea.
;Cons necesita que el primer argumento sea el nuevo elemento.