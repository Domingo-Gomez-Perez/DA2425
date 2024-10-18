#lang racket

(define (fast-expt-iter base exponente)
  (define (iter base exponente resultado)
    (cond ((= exponente 0) resultado)               
          ((even? exponente)                        
           (iter (* base base) (/ exponente 2) resultado))
          (else                                     
           (iter base (- exponente 1) (* resultado base)))))
  (iter base exponente 1))  

;Ejemplo
(fast-expt-iter 3 9)