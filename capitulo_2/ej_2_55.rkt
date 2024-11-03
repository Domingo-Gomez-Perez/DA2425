#lang racket
;Exercise 2.55: Eva Lu Ator types to the interpreter the expression

(car (quote (quote abracadabra)))
;To her surprise, the interpreter prints back quote. Explain.

;''abracadabra es igual a (quote (quote abracadabra))