#lang racket
(define nil null)

(define items (list 1 2 3 4 5 6 7 8 9 10))

(define (square-list-1 items)
  (if (null? items)
      nil
      (cons  (* (car items) (car items))
      (square-list-1 (cdr items)))
      ))

(square-list-1 items)

(define (square-list-2 items)
  (map (lambda (x) (* x x)) items))

(square-list-2 items)