#lang racket
;Exercise 2.54: Two lists are said to be equal? if they contain equal elements arranged in the same order. For example,

;(equal? '(this is a list) 
;        '(this is a list))
;is true, but

;(equal? '(this is a list) 
;        '(this (is a) list))
;is false. To be more precise, we can define equal? recursively in terms of the basic eq? equality of symbols by saying that a and b are equal?
;if they are both symbols and the symbols are eq?, or if they are both lists such that (car a) is equal? to (car b) and (cdr a) is equal? to (cdr b).
;Using this idea, implement equal? as a procedure. (Note: This implementation is only concerned with lists of symbols).

;Para ello sera necesario mirar algunos casos base, como que esten vacias
(define (equal? lista1 lista2)
(cond ((and (null? lista1) (null? lista2)) #t) ;Si las 2 estan vacias, deberia devolver correcto
      ((or (null? lista1) (null? lista2)) #f) ;Si una de las 2 esta vacia y la otra no, debe volver falso
      ((and (symbol? lista1) (symbol? lista2)) ;Si los dos elementos son simbolos, es decir se ha cogido el elemento de la lista, comparo si son iguales 
            (eq? lista1 lista2))
      ((and (list? lista1) (list? lista2)) ;Si los dos elementos son listas, compruebo recursivamente si el primer elemento de cada lista y el resto son iguales
      (and (equal? (car lista1) (car lista2)) (equal? (cdr lista1) (cdr lista2))))
      (else #f)) ;En caso contrario, devuelvo #f
  )

(equal? '(this is a list) 
        '(this is a list)) ;#t

(equal? '(this is a list) 
        '(this (is a) list)) ;#f

;Note: In practice, programmers use equal? to compare lists that contain numbers as well as symbols. Numbers are not considered to be symbols.
;The question of whether two numerically equal numbers (as tested by =) are also eq? is highly implementation-dependent.
;A better definition of equal? (such as the one that comes as a primitive in Scheme) would also stipulate that if a and b are both numbers, then a and b are equal?
;if they are numerically equal. Can you modify (equal?) to also work with numbers?
(define (equal?Numb lista1 lista2)
(cond ((and (null? lista1) (null? lista2)) #t)
      ((or (null? lista1) (null? lista2)) #f) 
      ((and (number? lista1) (number? lista2)) (= lista1 lista2)) ;CASO AÑADIDO PARA ACEPTAR NUMEROS
      ((and (symbol? lista1) (symbol? lista2))
            (eq? lista1 lista2))
      ((and (list? lista1) (list? lista2))
      (and (equal?Numb (car lista1) (car lista2)) (equal?Numb (cdr lista1) (cdr lista2))))
      (else #f))
  )

(equal? '(1 2 3) '(1 2 3)) ;#f
(equal?Numb '(1 2 3) '(1 2 3)) ;#t
(equal?Numb '(1 2 3) '(1 2 4)) ;#f
(equal?Numb '(a b c) '(a b c)) ;#t