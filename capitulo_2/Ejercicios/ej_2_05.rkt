#lang racket

(define (cons z)
  (define (cons-iter a b z)
    (cond
      ((= z 1) (list a b))
      ((even? z) (cons-iter (+ a 1) b (quotient z 2)))
      ((= (remainder z 3) 0) (cons-iter a (+ b 1) (quotient z 3)))
      (else #f)))
  (cons-iter 0 0 z))
      

(define (car z)
  (define (car-iter a z)
    (cond
      ((= z 1) a)
      ((even? z) (car-iter (+ a 1) (quotient z 2)))
      ((= (remainder z 3) 0) (car-iter a (quotient z 3)))
      (else #f)))
  (car-iter 0 z))


(define (cdr z)
  (define (cdr-iter b z)
    (cond
      ((= z 1) b)
      ((even? z) (cdr-iter b (quotient z 2)))
      ((= (remainder z 3) 0) (cdr-iter (+ b 1) (quotient z 3)))
      (else #f)))
  (cdr-iter 0 z))


(cons 18)
(car 18)
(cdr 18)