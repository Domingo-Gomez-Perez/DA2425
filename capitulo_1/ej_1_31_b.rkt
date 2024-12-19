#lang racket

(define (prod_rec term a next b)
  (if (> a b)
      1
      (* (term a)
         (prod_rec term (next a) next b))))

(define (inc x) (+ x 1))
(define (square x) (* x x))

(prod_rec square 1 inc 7)