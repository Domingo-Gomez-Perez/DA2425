#lang racket

(define (same-parity x . xs)
  (define (same-parity-aux lst parity)
    (cond
      ((null? lst) '())
      ((= (modulo (car lst) 2) parity)
       (cons (car lst) (same-parity-aux (cdr lst) parity)))
      (else
       (same-parity-aux (cdr lst) parity))))
  (same-parity-aux (cons x xs) (modulo x 2)))


; Ejemplos:
(same-parity 1 2 3 4 5 6 7) ; Deberia devolver (1 3 5 7)

(same-parity 2 3 4 5 6 7) ; Deberia devolver (2 4 6)

