#lang racket
(define (square-list items)
  (if (null? items)
      null
      (cons (sqr(car items)) (square-list (cdr items)))))

(define (square-list2 items)
  (map sqr items))

(square-list (list 1 2 3 4))
(square-list2 (list 1 2 3 4))