#lang racket

; Exercise 2.28

; Write a procedure `fringe` that takes as argument a tree (represented as a list) and returns a list whose
; elements are all the leaves of the tree arranged in left-to-right order.

(define (fringe lst)
  (cond
    ((null? lst) null)
    ((not (list? lst)) (list lst))
    (else (append (fringe (car lst)) (fringe (cdr lst))))))
	
                                
; Tests:                         
(define x 
  (list (list 1 (list 2 3) 4 (list 5 6))))

x                   ; Should return '((1 (2 3) 4 (5 6)))
(fringe x)          ; Should return '(1 2 3 4 5 6)
(fringe (list x x)) ; Should return '(1 2 3 4 5 6 1 2 3 4 5 6)