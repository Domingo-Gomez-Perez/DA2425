#lang racket
(define (iter-exp a b)
  (cond ((= b 0) 1)
        ((= a 0) 0)
        ((= a 1) 1)
        ((= b 1) a)
        (else 
        (if (even? b)     
            (iter-exp (* a a) (/ b 2))  
            (* a (iter-exp a (- b 1))))))) 
        
  
(iter-exp 2 5)
