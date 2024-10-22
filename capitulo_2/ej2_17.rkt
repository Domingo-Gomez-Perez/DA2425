#lang racket

; **Exercise 2.17:** Define a procedure
; `last-pair` that returns the list that contains only the last element of a
; given (nonempty) list:

; ```
; (last-pair (list 23 72 149 34))
; (34)
; ```

(define (last-pair lst)
  (if (null? (cdr lst))  ;; Si la cola es vacía, significa que es el último par.
      lst               ;; Devolvemos este par (que contiene el último elemento).
      (last-pair (cdr lst))))  ;; Si no es el último par, seguimos recursivamente.

(last-pair (list 23 72 149 34))
; (34)

(last-pair (list 1 2 3 4 5 6 7 8 9 10 11 12))
;; Resultado: '(12), comprobado

(last-pair (list 4499))
;; Resultado: '(4499)






