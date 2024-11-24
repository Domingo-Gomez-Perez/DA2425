#lang racket
;Ejercicio 2.23

(define (for-each p sequence)
  (if (null? sequence)
      null
      (begin
        (p (car sequence))  
        (for-each p (cdr sequence))))) 

(for-each 
 (lambda (x) (newline) (display x))
 (list 57 321 88))