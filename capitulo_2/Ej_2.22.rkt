#lang racket
(define nil null)

(define items (list 1 2 3 4 5))

(define (square x); Funcion auxiliar
  (* x x)
  )

; Parte 1
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))

(square-list items)

; La función itera sobre los elementos de items, y va almacenando los resultados en la variable answer.
; El orden es inverso ya que los elementos nuevos se introducen con (cons (square (car things)) answer), los elementos ultimos aparecen los primeros ya que se añaden las soluciones al principio.

; Parte 2

(define (square-list-2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square 
                     (car things))))))
  (iter items nil))

(square-list-2 items)

;El error es originado por el hecho de que el null de la lista answer que indica el final de la lista no se elimina por lo que en
;vez de obtener (answer (resultado de square)) se obtiene ((answer) . (resultado de square)) por lo que se obtiene una lista anidada en otra en vez de una sola lista con los resultados.

