#lang racket
(define (equal?1 a b)
  (cond
    ((and (symbol? a) (symbol? b)) (eq? a b))
    ((and (number? a) (number? b)) (= a b)) ; Modificacion para tratar numeros
    ((and (pair? a) (pair? b))
     (and (equal?1 (car a) (car b))
          (equal?1 (cdr a) (cdr b))))
    ((and (null? a) (null? b)) #t)
    ; Cualquier otro caso, no son iguales
    (else #f)))


; Ejemplos:

(equal?1 '(this is a list) '(this is a list)) ; Deberia devolver #t
(equal?1 '(this is a list) '(this (is a) list)) ; Deberia devolver #f

(equal?1 'x 'x) ; Deberia devolver #t
(equal?1 'x 'y) ; Deberia devolver #f

(equal?1 42 42) ; Deberia devolver #t
(equal?1 42 43) ; Deberia devolver #f
