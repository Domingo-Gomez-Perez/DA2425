#lang racket
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))



;Necesitamos hacer el programa de arriba a iterativo
(define (sum-it term a next b)
  (define(iter a result)
    (if (> a b)
        result           ;Si a > b entonces devolvemos el resultado
        (iter (next a) (+ result (term a))))) ; si no se realiza otra vez la funcion con el next a y el resultado sumado
  (iter a 0))

(define (inc n) (+ n 1))

(define (identity x) x)