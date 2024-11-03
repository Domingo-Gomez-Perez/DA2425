#lang racket
;Exercise 2.18: Define a procedure reverse that takes a list as argument and returns a list of the same elements in reverse order:

;(reverse (list 1 4 9 16 25))
;(25 16 9 4 1)
;Bonus: Can you design an algorithm that requires only n steps for a list containing n items?
(define (reverseaux lista resultado)
    (if (null? (cdr lista)) (cons (car lista) resultado) ;Si no hay mas elementos
        (reverseaux (cdr lista) (cons (car lista) resultado))));Si hay mas elementos quito de la lista el primer elemento y lo añado al final del resultado

;inicializo el resultado a null
(define (reverse lista) (reverseaux lista null))

(reverse (list 2 6 3 1 9 4 8))


;Este algoritmo solo necesita n pasos