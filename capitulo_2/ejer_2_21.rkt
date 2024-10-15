#lang racket

(define (square-list1 items)
  (if (null? items)
      #f ; ¿COMO DEVUELVO NIL?
      (cons (* (car items) (car items)) (square-list1 (cdr items)))))

(square-list1 (list 1 2 3 4))

(define (square-list2 items)
  (map (lambda (x) (* x x)) items))

(square-list2 (list 1 2 3 4))