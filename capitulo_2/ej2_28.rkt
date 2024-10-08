#lang racket

; **Exercise 2.28:** Write a procedure `fringe`
; that takes as argument a tree (represented as a list) and returns a list whose
; elements are all the leaves of the tree arranged in left-to-right order.  For
; example,

; ```
; (define x 
;   (list (list 1 2) (list 3 4)))

; (fringe x)
; (1 2 3 4)

; (fringe (list x x))
; (1 2 3 4 1 2 3 4)
; ```

(define (fringe tree)
  (cond
    [(null? tree) '()]  ; Si el árbol está vacío, devuelve una lista vacía
    [(not (list? (car tree)))  ; Si el primer elemento no es una lista
     (cons (car tree) (fringe (cdr tree)))]  ; Agrega el elemento a la lista de hojas y continúa
    [else  ; Si el primer elemento es una lista
     (append (fringe (car tree)) (fringe (cdr tree)))]))  ; Recurre en el primer elemento y en el resto

; Ejemplos de uso
(define x 
  (list (list 1 2) (list 3 4)))

; Imprimir el resultado de fringe
(fringe x)                   ; Resultado: (1 2 3 4)
(fringe (list x x))         ; Resultado: (1 2 3 4 1 2 3 4)





