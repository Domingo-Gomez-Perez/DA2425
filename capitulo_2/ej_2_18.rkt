#lang racket


(define (reverse lista)
  (if (null? lista) ;vemos si la lista esta vacia
      '()           ; caso base: lista vacia se devuelve esta
      (append (reverse (cdr lista)) (list (car lista))))) ; se va añadiendo a la lista
; el primer valor de nuestra lista y se llama recursivamente a las demas

(reverse (list 1 4 9 16 25))

;Can you design an algorithm that requires only n steps for a list containing n items?
;se tiene que hacer de forma iterativa
(define (reverse-iter lista)
  (define (iter lst result)
    (if (null? lst)
        result
        (iter (cdr lst) (cons (car lst) result))))
  (iter lista '()))

(reverse-iter (list 1 4 9 16 25))