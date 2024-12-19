#lang racket

(define (double func)
  (lambda (x) (func (func x))))

(define (inc n) (+ n 1))

(((double (double double)) inc) 5)