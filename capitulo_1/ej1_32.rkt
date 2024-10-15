#lang racket
; recursivo
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
         (accumulate combiner null-value term (next a) next b))))

; iterativo (2)
(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

; probar suma
(accumulate + 0 (lambda (x) (* x x)) 2 (lambda (x) (+ x 1)) 4)
(accumulate-iter + 0 (lambda (x) (* x x)) 2 (lambda (x) (+ x 1)) 4)

; probar producto
(accumulate * 1 (lambda (x) (* x x)) 2 (lambda (x) (+ x 1)) 4)
(accumulate-iter * 1 (lambda (x) (* x x)) 2 (lambda (x) (+ x 1)) 4)
