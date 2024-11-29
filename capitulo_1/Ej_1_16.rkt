#lang racket
(define (fast-expt b n)
  (define (iter base exp result)
    (cond ((= exp 0) result) ; Si el exponente es 0, devolvemos el resultado acumulado
          ((even? exp) (iter (* base base) (/ exp 2) result)) ; Si el exponente es par, cuadramos la base y dividimos el exponente
          (else (iter base (- exp 1) (* result base))))) ; Si el exponente es impar, multiplicamos el resultado por la base y restamos 1 al exponente
  (iter b n 1)) ; Llamada inicial con base `b`, exponente `n` y resultado `1`
