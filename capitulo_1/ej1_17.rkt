#lang racket

(define (mul a b)
  (if (= b 0)
      0
      (+ a (mul a (- b 1)))))

(define (double x) (+ x x)) 
(define (halve x) (/ x 2))   

(define (mul2 a b)
  (cond ((= b 0) 0)                          
        ((even? b) (mul2 (double a) (halve b))) 
        (else (+ a (mul2 a (- b 1))))))  

;Ejemplo
(mul2 27 10)