#lang racket

; Metodo recursivo
(define (reverse lst)
  (if (null? lst)
      '()                     ; Si la lista esta vacia retorna la lista vacia
      (append (reverse (cdr lst)) (list (car lst))) ; Da la vuelta a la lista recursivamente 
  ))

; Metodo iterativo
(define (reverse1 lst)
  (define (reverse-iter lst result)
    (if (null? lst)
        result              ; Cuando la lista esta vacia devuelve result 
        (reverse-iter (cdr lst) (cons (car lst) result)) ; 
    ))
  (reverse-iter lst '()))    ; Empieza con un resultado vacio.


; Ejemplos:
(reverse (list 1 4 9 16 25)) ; Deberia devolver (25 16 9 4 1) (metodo recursivo)

(reverse1 (list 1 4 9 16 25)) ; Deberia devolver (25 16 9 4 1)(metodo iterativo)
