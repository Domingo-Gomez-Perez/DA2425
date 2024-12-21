#lang racket

(define x 
  (list (list 1 2) (list 3 4)))

x

(define (reverse lista)
  (if (null? lista) ;vemos si la lista esta vacia
      '()           ; caso base: lista vacia se devuelve esta
      (append (reverse (cdr lista)) (list (car lista)))))



(reverse x)

(define (deep-reverse lista)
  (cond
    ((null? lista) '())  ;Mirar si la lista esta vacia                    
    ((list? (car lista)) ;Si el primer elemento es una lista                 
     (append (deep-reverse (cdr lista)) ;hago deep-reverse con lo demas de la lista   
             (list (deep-reverse (car lista))))) ;hago una lista de deep-reverse sobre la lista del 1 elemento
    (else       ;si el primer elemento es un numero normal        
     (append (deep-reverse (cdr lista)) ;hago el append como el reverse
             (list (car lista))))))     

(deep-reverse x)
