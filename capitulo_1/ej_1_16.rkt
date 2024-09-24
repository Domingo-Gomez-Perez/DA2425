#lang racket
;Ejercicio 1.16

(define (square x) (* x x))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))

;Su version iterativa a continuacion

(define (fast-expt-iter b n c)
  (cond ((= n 0) c)
        ((even? n) (fast-expt-iter (* b b) (/ n 2) c))
        (else (fast-expt-iter b (- n 1) (* c b)))))

(fast-expt-iter 2 4 1)