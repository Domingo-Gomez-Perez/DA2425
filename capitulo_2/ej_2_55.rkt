#lang racket

; Exercise 2.55

; Eva Lu Ator types to the interpreter the expression (car ''abracadabra)
; To her surprise, the interpreter prints back `quote`.


; As we can see, the expression ''abracadabra is equivalent to (quote (quote abracadabra)).

''abracadabra                      ; ''abracadabra
(quote (quote abracadabra))        ; ''abracadabra

; When you take the car of (quote (quote abracadabra)), you get the first element
; of the list (quote abracadabra), which is quote. Into a `quote`, the word `quote`
; doesn't act as an reserved word. This can be easily saw by changing `quote` to `other`:

(car (quote (quote abracadabra)))  ; 'quote
(car (quote (other abracadabra)))  ; 'other