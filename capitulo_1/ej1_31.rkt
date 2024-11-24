#lang racket

(define (iden n) n)
(define (inc n) (+ n 1))

(define (product term a next b)
  (if (> a b)
      1   ; Si a > b, el producto es 1
      (* (term a) (product term (next a) next b))))

(define (factorial n)
  (product iden 1 inc n))


(define (product-pi n)
  (define (numerator k) (if (even? k) (+ k 2) (+ k 1)))  
  (define (denominator k) (if (even? k) (+ k 1) (+ k 2))) 
  (* 4 (product (lambda (k) (/ (numerator k) (denominator k)))
                1 inc n)))

(product-pi 27)
(factorial 5)




(define (productb term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1)) 

(define (factorial n)
  (productb iden 1 inc n))

;Ejemplo
(factorial 5)