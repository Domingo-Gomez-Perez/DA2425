#lang racket


; Hecho por ALVARO GONZALEZ NAVA

;term
(define (square x) (* x x))

;next
(define (inc x) (+ x 1))


;Iterativa
(define (accumulate_it combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))


;Recursiva
(define (accumulate_rec combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate_rec combiner null-value term (next a) next b))))
(accumulate_rec + 0 square 1 inc 4)

(accumulate_it + 0 square 1 inc 4)
