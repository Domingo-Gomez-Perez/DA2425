#lang racket
(car ''abracadabra)

;Como muestran los siguientes ejemplos, lo que pasa es que se está dejando sin evaluar a la función
;'quote', de ahí que se la imprima en pantalla en vez de evaluar su contenido.
(car '''abracadabra)
(car ''''abracadabra)

;Este ejemplo es equivalente al problema expuesto:
(define a 5)
'a