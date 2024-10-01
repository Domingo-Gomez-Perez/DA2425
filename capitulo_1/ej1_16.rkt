#lang racket


; **Exercise 1.16:** Design an iterative version of the `fast-expt`
; procedure given in the text.  Hint: to do this, it might help to use a
; subtle trick of algorithm design.  Normally when implementing an
; algorithm, you're thinking about how to break a problem down into
; smaller and smaller steps (e.g., subdividing the problem into parts).  However,
; sometimes it might make sense to change the problem into a different, but
; equivalent problem.  For example, suppose you were computing
; `2^16`. You could rewrite this problem by doubling the base and halving the exponent.
; Thus, it's really the same as computing `4^8`.  Perhaps this trick could be used
; in your solution.

(define (fast-expt-iter a b)
  (define (iter a b result)
    (cond
      [(= b 0) result]  ; Si el exponente llega a 0, devolvemos el resultado.
      [(even? b) (iter (* a a) (/ b 2) result)] ; Si "b" es par, cuadramos "a" y reducimos "b" a la mitad.
      [else (iter a (- b 1) (* result a))])) ; Si es impar, restamos 1 al exp (b) y multiplicamos el result acumulado por "a".
  (iter a b 1)) ; Llamada inicial con el resultado acumulado en 1.

(fast-expt-iter 2 5) ; 32
(fast-expt-iter 2 8) ; 256
(fast-expt-iter 3 7) ; 2187
(fast-expt-iter 4 9) ; 262144

;Comprobado el correcto funcionamiento de fast-exp-iter