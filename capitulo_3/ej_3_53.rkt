#lang racket
;Ejercicio 3.53


(define (add-streams s1 s2)
  (stream-cons 
    (+ (stream-first s1) (stream-first s2))
    (add-streams (stream-rest s1) (stream-rest s2))))

(define s (stream-cons 1 (add-streams s s)))

;El primer elemento de (add-streams s s) es 1 + 1 = 2
;El segundo elemento se calcula sumando el segundo elemento de s consigo mismo

;1 + 1 = 2
;2 + 2 = 4
;4 + 4 = 8
;8 + 8 = 16
;    .
;    .
;    .


;La secuencia s, son las potencias de 2