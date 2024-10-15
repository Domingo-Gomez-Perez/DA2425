#lang racket
; Ejercicio 1.30

(define (identity n) n)

(define (sumaUno n) (+ n 1))

(define (sum-rec term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum-rec term (next a) next b))))

(define (sum-it term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)) )))
  (iter a 0))

;(define (funcion y parametros) (funcion auxiliar) (desarrollo de la funcion))
(sum-it identity 1 sumaUno 4)