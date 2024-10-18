#lang racket

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result                    
        (iter (next a) (+ result (term a)))))  
  (iter a 0))
(define (iden x) x)
(define (inc x) (+ x 1))

;Ejemplo
(sum iden 1 inc 7)  