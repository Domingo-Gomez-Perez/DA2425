#lang racket 

; **Exercise 2.27:** Modify your `reverse`
; procedure of Exercise 2.18 to produce a `deep-reverse` procedure
; that takes a list as argument and returns as its value the list with its
; elements reversed and with all sublists deep-reversed as well.  For example,

; ```
; (define x 
;   (list (list 1 2) (list 3 4)))

; x
; ((1 2) (3 4))

; (reverse x)
; ((3 4) (1 2))

; (deep-reverse x)
; ((4 3) (2 1))
; ```

(define (deep-reverse lst)
  (cond
    [(null? lst) '()]  ;; Si la lista está vacía, devolvemos la lista vacía.
    [else (append (deep-reverse (cdr lst)) 
                  (list (if (list? (car lst)) 
                             (deep-reverse (car lst)) 
                             (car lst))))])) ;; Reversamos primero los elementos.

(define x 
  (list (list 1 2) (list 3 4)))

; Imprimir la lista original
x
; Resultado: ((1 2) (3 4))

; Imprimir el resultado de reverse
(reverse x)
; Resultado: ((3 4) (1 2))

; Imprimir el resultado de deep-reverse
(deep-reverse x)
; Resultado: ((4 3) (2 1))
