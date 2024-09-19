#lang racket

(define (square x) (* x x))
(define (inc n) (+ n 1))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (repeated-iter f n original)
    (if (= n 1) (lambda (x) (f x)) (repeated-iter (compose original f) (- n 1) original)))
  (repeated-iter f n f))


((repeated square 2) 5)    ;-> 625
((repeated inc 5) 4)       ;-> 9
