#lang racket

(define s (stream-cons 1 (add-streams s s)))

; Va duplicando el resultado anterior empezando con el primer elemento que es 1 dando lugar a 1 -> 2 -> 4, etc,
; Potencias de 2
