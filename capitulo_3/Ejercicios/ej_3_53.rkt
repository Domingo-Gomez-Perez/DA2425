#lang racket

(define (add-streams s1 s2) 
  (stream-map + s1 s2))
(define s (stream-cons 1 (add-streams s s)))

;El flujo s comienza con el valor 1, como lo indica stream-cons 1.
;Los siguientes elementos del flujo se calculan como add-streams s s, lo que significa que se suman dos copias del flujo s. Por lo que aparecera en un elemento el doble del anterior
;Por ejemplo: 1,2,4,8,16,32,64...