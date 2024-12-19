#lang racket

(define (square x) (* x x))
(define (inc n) (+ n 1))

(define (compose a b)
  (lambda (x) (a (b x))))

(define (repeated a n)
  (define (repeated-iter a n original)
    (if (= n 1) (lambda (x) (a x)) (repeated-iter (compose original a) (- n 1) original)))
  (repeated-iter a n a))

((repeated square 2) 5)    ;-> 625
