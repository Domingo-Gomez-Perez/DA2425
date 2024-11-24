#lang racket
;Ejercicio 2.55
(car ''abracadabra)
;En esta expresión, los dos apóstrofes equivalen a dos quote.
;Sería lo mismo que:
(car (quote (quote abracadabra)))

;Por ello, el interprete printa "quote"
