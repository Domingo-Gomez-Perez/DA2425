#lang racket
(display"\nExercise 2.55\n")
; **Exercise 2.55:** Eva Lu Ator types to the
; interpreter the expression

; ```
; (car ''abracadabra)
; ```
; To her surprise, the interpreter prints back `quote`.  Explain.

;   'abracadabra == (quote abracadabra)
;  ''abradacabra == (quote (quote abracadabra))

(car ''abracadabra)
;Lo que sucede es:
;(car (quote (quote abracadabra)))
;Por lo que car obtiene el primer elemento de la lista (quote)

(equal? (car ''abracadabra) 'quote); Retorna True, por lo que comentaba antes

(cdr (list 2 '''abracadabra)); Retorna '(''abracadabra)
(cdr (list '''abracadabra 2)); Retorna '(2)

(car (list 2 '''abracadabra)); Retorna 2
(car (list '''abracadabra 2)); Retorna '''abracadabra
(car (car (list '''abracadabra 2))); Retorna 'quote
(cdr '''abracadabra); Retorna '('abracadabra)
(cadr '''abracadabra); Retorna ''abracadabra
(cadr (cadr '''abracadabra)); Esta es la única forma para recibir la lista abracadabra (en forma de 'abracadabra)


