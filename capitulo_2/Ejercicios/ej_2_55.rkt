#lang racket
(car ''abracadabra)
;La 'x transforma la expresion en (quote x) por lo que al hacer ''(abracadabra) se transforma en (quote (quote abracadabra))
;y al hacer car de esa expresion se retorna el primer elemento, es decir, quote