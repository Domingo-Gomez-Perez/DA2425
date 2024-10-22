#lang racket
(define (square x) (* x x))

(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))

(define (fast-expt-iter b n)
  (define (expt-iter a b n)
    (cond ((= n 0) a)
          ((even? n)
           (expt-iter a (square b) (/ n 2)))
          (else
           (expt-iter (* a b) b (- n 1)))))
  (expt-iter 1 b n))
          