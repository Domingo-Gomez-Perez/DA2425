#lang racket
(define (product-iterativo term a next b)
  (define (iter current result)
    (if (> current b)
        result 
        (iter (next current) (* result (term current)))))  
  (iter a 1))

(define (id x) x) ;Identidad
(define (siguiente x) (+ x 1)); Siguiente

(product-iterativo id 1 siguiente 3)

(define (product-recursivo term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-recursivo term (next a) next b))))

(product-recursivo id 10 siguiente 11)

(define (factorial x)
  (product-recursivo id 1 siguiente x)
  )

(factorial 5)

(define (pi x)
  (/ (product-recursivo term-pi 2 next-pi x) (product-recursivo term-pi 3 next-pi x))
)
(define (next-pi x)
  (+ x  2) ; No consigo hacer que funcione para impares
  )

(define (term-pi x)
  (* x x)
  )
(pi 2000)