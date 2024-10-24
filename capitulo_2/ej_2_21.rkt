#lang racket

; Exercise 2.21

; Define a procedure `square-list` that takes a list of numbers
; as argument and returns a list of the squares of those numbers.

; Example:
; (square-list (list 1 2 3 4)) ; Should return (1 4 9 16)

; Here are two different definitions of `square-list`.
; Complete both of them by filling in the missing expressions:

;Method 1
(define (square-list1 items)
  (if (null? items)
      '()
      (cons (* (car items) (car items)) (square-list1 (cdr items)))))

;Method 2
(define (square-list2 items)
  (map (lambda (x) (* x x)) items))


; Tests:
(square-list1 (list 1 2 3 4)) ; Should return (1 4 9 16)
(square-list2 (list 1 2 3 4)) ; Should return (1 4 9 16)