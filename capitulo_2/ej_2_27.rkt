#lang racket
;Exercise 2.27: Modify your reverse procedure of Exercise 2.18 to produce a deep-reverse procedure that takes a list as argument and returns as its
;value the list with its elements reversed and with all sublists deep-reversed as well. For example,

(define x 
  (list (list 1 2) (list 3 4)))

x
;((1 2) (3 4))

(define (reverseaux lista resultado)
    (if (null? (cdr lista)) (cons (car lista) resultado) ;Si no hay mas elementos
        (reverseaux (cdr lista) (cons (car lista) resultado))));Si hay mas elementos quito de la lista el primer elemento y lo añado al final del resultado

;inicializo el resultado a null
(define (reverse lista) (reverseaux lista null))

(reverse x)
;((3 4) (1 2))

(define (deep-reverseaux lista resultado)
    (if (null? (cdr lista)) (cons (if (list? (car lista)) (deep-reverseaux (car lista) null) (car lista)) resultado) ;Si no hay mas elementos
        (deep-reverseaux (cdr lista) (cons (if (list? (car lista)) (deep-reverseaux (car lista) null) (car lista)) resultado))));Si hay mas elementos quito de la lista el primer elemento y lo añado al final del resultado

;inicializo el resultado a null
(define (deep-reverse lista) (deep-reverseaux lista null))

(deep-reverse x)
;((4 3) (2 1))