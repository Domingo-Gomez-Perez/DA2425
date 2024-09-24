#lang racket
;Ejercicio 1.30
(define (id x) x)

(define (inc x) (+ x 1))

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))


 (sum id 2 inc 5)