#lang racket
; llamada original
(for-each 
 (lambda (x) (newline) (display x))
 (list 57 321 88))
(newline)

; nueva implementación de for-each
(define (my-for-each proc lst)
  (unless (null? lst)
    (proc (car lst))
    (my-for-each proc (cdr lst))))

; comprobar
(my-for-each
 (lambda (x) (newline) (display x))
 (list 58 322 89))
