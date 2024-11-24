#lang racket
(define (iden n) n)
(define (inc n) (+ n 1))

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value  
      (combiner (term a) (accumulate combiner null-value term (next a) next b)))) 

(define (sum term a next b)
  (accumulate + 0 term a next b))  
(define (product term a next b)
  (accumulate * 1 term a next b))  

;Ejemplo
(sum iden 1 inc 7)
(product iden 1 inc 7)


(define (accumulate2 combiner null-value term a next b)
  (define (iter a)
    (if (> a b)
        null-value 
        (combiner (term a) (iter (next a)))))  
  (iter a))  

(define (sum2 term a next b)
  (accumulate2 + 0 term a next b))  
(define (product2 term a next b)
  (accumulate2 * 1 term a next b)) 


