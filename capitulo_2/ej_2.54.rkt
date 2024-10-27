#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.54: Two lists are said to be equal? if they contain equal elements arranged
in the same order. For example,

(equal? '(this is a list)
        '(this is a list))
is true, but

(equal? '(this is a list)
        '(this (is a) list))
is false. To be more precise, we can define equal? recursively in terms of the basic
eq? equality of symbols by saying that a and b are equal? if they are both symbols and
the symbols are eq?, or if they are both lists such that (car a) is equal? to (car b)
and (cdr a) is equal? to (cdr b). Using this idea, implement equal? as a procedure.
(Note: This implementation is only concerned with lists of symbols).

Note: In practice, programmers use equal? to compare lists that contain numbers as
well as symbols. Numbers are not considered to be symbols. The question of whether
two numerically equal numbers (as tested by =) are also eq? is highly
implementation-dependent. A better definition of equal? (such as the one that
comes as a primitive in Scheme) would also stipulate that if a and b are both
numbers, then a and b are equal? if they are numerically equal. Can you modify
(equal?) to also work with numbers?
|#

; no hay que hacer que equal mire dentro de listas hasta encontrar simbolos
; solo tiene que mirar simbolos con simbolos y letras con letras

; tenemos muchos operadores para preguntar:
; symbol?
; number?
; pair?
; null?
; eq?

(define (equal? a b)
  (cond ((and (symbol? a) (symbol? b)) (eq? a b)) ; Si los dos son simbolos miramos tal cual
        ((and (pair? a) (pair? b)) ; Both are pairs (lists), recursively compare
         (and (equal? (car a) (car b)) (equal? (cdr a) (cdr b))))
        ((and (null? a) (null? b)) #t) ; Caso especial, los dos listas vacias
        (else #f))) ; Si no se cumple nada pues no son iguales

; pruebas
(display '(PRUEBAS 1))
(newline)
(equal? '(a b c) '(a b c)) ; true
(equal? '(a (b c)) '(a (b c))) ; true
(equal? '(a b c) '(a b (c))) ; false

(equal? '(1 2 3) '(1 2 3)) ; false, con numeros no va

; como estamos usando symbol, pues solo va a ir con simbolos no con numeros, hay que ampliarlo a numeros
; esto es adicional creo

(define (equal?-ampliado a b)
  (cond ((and (symbol? a) (symbol? b)) (eq? a b)) ; Si los dos son simbolos miramos tal cual
        ((and (number? a) (number? b)) (= a b)) ; los numeros los comparamos con el igual
        ((and (pair? a) (pair? b)) ; Both are pairs (lists), recursively compare
         (and (equal?-ampliado (car a) (car b)) (equal?-ampliado (cdr a) (cdr b))))
        ((and (null? a) (null? b)) #t) ; Caso especial, los dos listas vacias
        (else #f))); Si no se cumple nada pues no son iguales


; pruebas 2
(display '(PRUEBAS 2))
(newline)
(equal?-ampliado '(a b c) '(a b c)) ; true
(equal?-ampliado '(a (b c)) '(a (b c))) ; true
(equal?-ampliado '(a b c) '(a b (c))) ; false

(equal?-ampliado '(1 2 3) '(1 2 3)) ; true, ahora con numeros va