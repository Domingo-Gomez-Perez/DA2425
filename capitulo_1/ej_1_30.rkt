#lang racket

; Exercise 1.30

; The following `sum` procedure generates a linear recursion:

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
        (sum term (next a) next b))))

; The procedure can be rewritten so that the sum is performed
; iteratively. Show how to do this by filling in the missing
; expressions in the following definition:

(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

; Example usage
(sum (lambda (x) x) 1 (lambda (x) (+ x 1)) 10)
; Should return the sum of integers from 1 to 10, which is:
; 1+2+3+4+5+6+7+8+9+10 = 55 

(sum-iter (lambda (x) (* x x)) 1 (lambda (x) (+ x 1)) 6)
; Should return the sum of squares from 1 to 5, which is:
; 1+4+9+16+25+36 = 91