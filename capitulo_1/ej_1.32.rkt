#lang racket
(define (accumulate combiner null-value term a next b)
 (if (> a b)
      null-value
      (combiner (term a)
         (accumulate combiner null-value term (next a) next b))))


(define (suma x y) (+ x y))
(define (multiplicacion x y) (* x y))
(define (siguiente x) (+ x 1))
(define (id x) x)

;Sumatorio
(define (sum a b)
  (accumulate suma 0 id a siguiente b)
  )

(sum 1 3)

;Producto
(define (product a b)
  (accumulate multiplicacion 1 id a siguiente b)
  )
(product 1 5)

;Iterativo
(define (accumulate-iter combiner null-value term a next b)
  (define (iter current result)
    (if (> current b)
        result
        (iter (next current) (combiner result (term current)))))
  (iter a null-value))

;Prueba de iterativo
(accumulate-iter suma 0 id 1 siguiente 3) ;Ejemplo sumatorio
(accumulate-iter multiplicacion 1 id 1 siguiente 5) ;Ejemplo producto