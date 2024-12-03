#lang racket

(define (last-pair lst)
  (if (null? (cdr lst))     ; Mira si el resto de la lista esta vacia
      lst                   ; Si lo esta retorna el elemento de la lista
      (last-pair (cdr lst)) ; Si no continua con el resto de la lista
  ))


; Ejemplo

(define lista1 (list 1 4 9 6 7 2 8 3)) ; Creo una lista

(last-pair lista1) ; Me deberia devolver el elemento "3"