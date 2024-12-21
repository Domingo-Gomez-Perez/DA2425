#lang racket
;Exercise 3.53: Without running the program, describe the elements of the stream defined by

(define s (stream-cons 1 (add-streams s s)))

;Empezara uniendo un 1 por el stream-cons, posteriormente añadira dos veces el anterior, por lo que sera 2, continuara con un 4

;En resumen ira añadiendo las distintas potencias de 2, empezara con 2^0, y seguira 2^1, 2^2, 2^3, 2^4, 2^5, 2^6...