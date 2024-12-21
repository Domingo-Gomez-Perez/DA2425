#lang racket


;La implementacion de for-each
;tiene 2 argumentos; proceso y lista.
(define (for-each metodo lista)
  (if (null? lista)
      '()
      (begin
        (metodo (car lista))             ; Aplicar el procedimiento al primer elemento
        (for-each metodo (cdr lista))))) ; llamar otra vez recursivamente para el resto de la lista


(for-each 
 (lambda (x) (newline) (display x))
 (list 57 321 88))