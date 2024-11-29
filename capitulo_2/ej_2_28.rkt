#lang racket

(define (fringe arbol)
  (cond ((null? arbol) '())                  ; Si el árbol es vacío, devuelve la lista vacía
        ((not (pair? arbol)) (list arbol))     ; Si es una hoja, devuelve el elemento en una lista
        (else (append (fringe (car arbol))    ; Si es una lista, combina las hojas de las sublistas
                      (fringe (cdr arbol))))))

; Ejemplos:
(define lista1 (list (list 1 2) (list 3 4)))

(fringe lista1) ; Deberia devolver (1 2 3 4)

(fringe (list lista1 lista1)) ; Deberia devolver (1 2 3 4 1 2 3 4)

(define lista2 (list 1 2 (list 3 6) 4 (list (list 5 8) 9) 11))

(fringe lista2) ; Deberia devolver (1 2 3 6 4 5 8 9 11)
