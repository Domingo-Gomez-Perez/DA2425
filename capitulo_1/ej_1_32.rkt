#lang racket
;Ejercicio 1.32

(define (id x) x)

(define (inc x) (+ x 1))

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

;sum
(accumulate + 0 id 1 inc 10)

;product
(accumulate * 1 * 1 inc 10)

;accumulate iterativo
(define (accumulatei combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(accumulatei + 0 id 1 inc 10)