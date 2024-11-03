#lang racket

; **Exercise 2.18:** Define a procedure `reverse`
; that takes a list as argument and returns a list of the same elements in
; reverse order:

; ```
; (reverse (list 1 4 9 16 25))
; (25 16 9 4 1)
; ```

(define (reverse lst)
  (define (reverse-helper lst acc)
    (if (null? lst)      ;; Si la lista está vacía, devolvemos el acumulador
        acc              ;; que contiene la lista invertida.
        (reverse-helper (cdr lst) (cons (car lst) acc))))  ;; Cons el primer elemento en el acumulador y sigue.
  (reverse-helper lst '()))  ;; Llamada inicial con el acumulador vacío.

(reverse (list 1 4 9 16 25))
; (25 16 9 4 1), comprobado




