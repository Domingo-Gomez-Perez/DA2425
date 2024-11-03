#lang racket

; Exercise 2.18

; Define a procedure `reverse` that takes a list as argument
; and returns a list of the same elements in reverse order:

(define (reverse lst)
    (if (null? lst)
        lst
	(append (reverse (cdr lst)) (list (car lst)))))

; Tests:
 (reverse (list 1 4 9 16 25)) ; Should return (25 16 9 4 1)


; Bonus: Can you design an algorithm that requires only n steps for a list containing n items?h

; The previous method, despite being more intuitive, has an O(n^2) time complexity
; due to the call to append for each element. The new one reduces it to O(n)

(define (reverse_bonus lst)
  (define (f original reversed)
    (if (null? original)
        reversed
        (f (cdr original) (cons (car original) reversed))))
  (f lst '()))

; Tests:
 (reverse_bonus (list 1 4 9 16 25)) ; Should return (25 16 9 4 1)
