#lang racket

;Cuando el intérprete imprime "quote", es porque car ha
;devuelto una lista que está citada: (quote abracadabra). El intérprete la muestra usando la notación abreviada quote.
(car ''abracadabra)