#lang racket

(define (reverse list)
  (define (a list1 list2)
    (if (null? list1)
        list2
        (a (cdr list1) (cons (car list1) list2))))
  (a list '()))

(reverse (list 1 4 9 16 25))
