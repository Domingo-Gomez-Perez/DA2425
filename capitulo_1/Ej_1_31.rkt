#lang racket

; Perte 1

(define (iden x) x)

(define (sumaUno x) (+ x 1))

(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)) )))
  (iter a 1))

(define (factorial x) (product (lambda (y) y) 1 (lambda (z) (+ z 1)) x))

(factorial 4)

(define semi-pi (product (lambda (x) (* (/ (* 2 x) (- (* 2 x) 1)) (/ (* 2 x) (+ (* 2 x) 1)))) 1 (lambda (y) (+ y 1)) 100) )

(define (pi) (* semi-pi 4))

(pi)

; Mi product es iterativo, así que lo haré ahora recursivo

(define (product-rec term a next b)
  (if (> a b)
      1
      (* (term a) (product-rec term (next a) next b))
                                    ))

(product-rec iden 1 sumaUno 4)

