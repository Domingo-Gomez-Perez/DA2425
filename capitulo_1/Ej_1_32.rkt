#lang racket

; Recursiva
(define (accumulate1 operacion base term a next b)
  (if (> a b)
      base
      (operacion (term a)
                (accumulate1 operacion base term (next a) next b))))


; Iterativa
(define (accumulate2 operacion base term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (operacion (term a) result))))
  (iter a base))


(define (sum1 term a next b)
  (accumulate1 + 0 term a next b))

(define (product1 term a next b)
  (accumulate1 * 1 term a next b))

(define (sum2 term a next b)
  (accumulate2 + 0 term a next b))

(define (product2 term a next b)
  (accumulate2 * 1 term a next b))