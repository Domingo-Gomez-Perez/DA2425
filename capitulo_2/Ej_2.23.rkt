#lang racket
(define (for-each procedure list)
  (if (null? list)
  void ; Esto es para que no salga nada en el caso base
  (begin
  (procedure (car list))
  (for-each procedure (cdr list)))
  ))


(for-each 
 (lambda (x) (newline) (display x))
 (list 57 321 88))

