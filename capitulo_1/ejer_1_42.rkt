#lang racket

(define (square x) (* x x))
(define (inc n) (+ n 1))

(define (compose f g)
  (lambda (x) (f (g x))))

((compose square inc) 6)    ; -> 49
((compose (compose inc inc) inc) 7) ; -> 10