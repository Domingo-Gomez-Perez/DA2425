#lang racket

(define (last-pair lista)
  (if (null? (cdr lista)) ;Si no hay más elementos (cdr es nulo)
      (car lista)         ; Devolver la lista actual (que contiene el último elemento)
      (last-pair (cdr lista)))); Continuar con el resto de la lista



(last-pair (list 23 72 149 34))