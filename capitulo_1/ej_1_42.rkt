#lang racket

(define (square x) (* x x))
(define (inc n) (+ n 1))

(define (compose a b)
  (lambda (x) (a (b x))))

((compose square inc) 6)    ; -> 49
((compose (compose inc inc) inc) 7) ; -> 10