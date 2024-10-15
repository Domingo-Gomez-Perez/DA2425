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
;(car (quote (quote abracadabra)))
;Por lo que car obtiene el primer elemento de la lista (quote)