#lang racket
; Ejercicio 1.9

(define (inc x) (+ x 1))
(define (dec x) (- x 1))


; Procedimiento 1:
(define (plus1 a b)
  (if (= a 0) 
      b 
      (inc (plus1 (dec a) b))))

;(plus1 2 1)
;(inc(plus1 ((dec 2) 1))
;(inc(inc(plus1((dec(dec(2)) 1))))

; En el procedimiento anterior se van acumulando las operaciones de "inc",
; cuando se hace la llamada del procedimiento, que se resuelven al final
; ,por lo tanto, se trata de un proceso recursivo.


(define (plus2 a b)
  (if (= a 0) 
      b 
      (plus2 (dec a) (inc b))))

;(plus2 2 1)
;(plus2 (dec 2) (inc 1))
;(plus2 (dec(dec 2)) (inc(inc(1)))

;En el procedimiento anterior mientras avanza no deja operaciones que realizar
; al final, ya que los valores se actualizan en cada llamada, por lo tanto, es
; un proceso iterativo.

(plus1 2 1)
(plus2 2 1)