#lang racket

(define (for-each proc lst)
  (if (null? lst)
      #t ; 
      (begin
        (proc (car lst)) 
        (for-each proc (cdr lst))))) ; Llama recursivamente con el resto de la lista

;Ejemplo
(for-each 
 (lambda (x) 
   (newline) 
   (display x))
 (list 2 5 10))

