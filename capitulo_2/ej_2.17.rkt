#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.17: Define a procedure last-pair that returns the list that contains
only the last element of a given (nonempty) list:

(last-pair (list 23 72 149 34))
(34)
|#

; vamos recorriendo toda la lista pero miramos uno por delante para ver el null
(define (last-pair lst)
  (if (null? (cdr lst))  ; Si el siguiente elemento es nulo, hemos llegado al final
      lst                ; Retornamos la lista con el último elemento
      (last-pair (cdr lst)))) ; De lo contrario, seguimos avanzando en la lista

; pruebas
(last-pair (list 23 72 149 34)) ; => '(34)
