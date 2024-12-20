#lang racket

(define (add-streams s1 s2)
  (stream-cons 
    (+ (stream-first s1) (stream-first s2))
    (add-streams (stream-rest s1) (stream-rest s2))))

(define s (stream-cons 1 (add-streams s s)))

;Este calcula la suma del primer elemento con el mismo.
;Una vez tiene el calculo, repite este de nuevo, creando asi una generacion de potencias de 2.
;El resultado seria:
; 2 -> 1+1
; 4 -> 2+2
; 8 -> 4+4
; ...
;La sucesion generada por s es la correspondiente a las potencias de 2.