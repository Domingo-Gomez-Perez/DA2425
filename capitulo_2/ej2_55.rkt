#lang racket
(car ''abracadabra) ; -> 'quote
(car '(quote abracadabra)) ; -> 'quote
(car (quote (quote abracadabra))) ; -> 'quote

; Explicación:
;
; El código ''abracadabra es una forma abreviada de escribir (quote (quote abracadabra)).
; Esto significa que no se está citando el símbolo abracadabra directamente, sino que se está
; citando una estructura que ya fue citada previamente. Si lo expandimos, tenemos:
; (quote (quote abracadabra))
; Esto significa que el valor de ''abracadabra es (quote abracadabra), una lista cuya cabeza es
; el símbolo quote y cuyo segundo elemento es el símbolo abracadabra.
; De esta manera, al aplicar car, se obiene el primer elemento, esto es, 'quote.
