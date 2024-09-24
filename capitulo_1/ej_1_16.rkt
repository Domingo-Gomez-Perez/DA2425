#lang racket

(define (even? n)
  (= (remainder n 2) 0))

(define (square x)
  (* x x))

(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))


(define (fast-expt-iter-aux b n contador)
    (cond ((= n 0) contador)
        ((even? n) (fast-expt-iter-aux (square b) (/ n 2) contador))
        (else (fast-expt-iter-aux b (- n 1) (* contador b)))))

(define (fast-expt-iter b n)  (fast-expt-iter-aux b n 1))

(fast-expt-iter 2 8)