#lang racket


; Hecho por ALVARO GONZALEZ NAVA


;Este es un proceso recursivo
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

; Para definir factorial con product
(define (factorial n)
  (product (lambda (x) x) 1 (lambda (x) (+ x 1)) n))

; Calcular pi
(define (pi)
  (/ (product (lambda (x) x) 2 (lambda (x) (+ x 2)) 4)
     (product (lambda (x) x) 1 (lambda (x) (+ x 2)) 4)))


;next
(define (inc x) (+ x 1))

;term
(define (identity x) x)

;El programa product de forma iterativa seria de la sigueinte forma
(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))


