#lang racket
(define (even? n)
  (= (remainder n 2) 0))

(define (square n)
  (* n n))

(define (halve n)
  (/ n 2))

(define (fast-expt b n) 
  (fast-expt-iter b n 1))

(define (fast-expt-iter b n product)
  (cond ((= n 0)
         product)
        ((even? n) 
         (fast-expt-iter (square b) (halve n) product))
        (else 
         (fast-expt-iter b (- n 1) (* b product)))))

(fast-expt 3 3)
