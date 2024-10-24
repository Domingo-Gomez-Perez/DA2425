#lang racket

; Exercise 2.22

; Louis Reasoner tries to rewrite the first `square-list` procedure of Exercise 2.21 so that it
; evolves an iterative process:

(define (square-list1 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) (cons (sqr (car things)) answer) )
     )
  )
  
  (iter items '())
)

; Unfortunately, defining `square-list` this way produces the answer list in
; the reverse order of the one desired. Why?

(square-list1 (list 1 2 3 4)) ; Should return '(16 9 4 1)

; The defined 'iter' method takes 2 arguments: `things`, which is the remaining
; list to work with, and `answer`, which is the list that contains the results.

; As we can see, if we apply substitution, we are adding the elements to the
; beginning of the `answer` list while reading the first part of the `things` list 

; Brief clarifying substitution:
; ...
; (iter (cdr (list 1 2 3 4)) (cons (sqr (car (list 1 2 3 4))) '())))
; (iter (list 2 3 4) (list 1))
; (iter (list 3 4) (cons (sqr (car (list 2 3 4))) (list 1)))
; (iter (list 3 4) (list 4 1))
; (iter (list 4) (cons (sqr (car (list 3 4))) (list 4 1)))
; (iter (list 4) (list 9 4 1))
; ...



; Louis then tries to fix his bug by interchanging the arguments to `cons`:

(define (square-list2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) (cons answer (sqr (car things))))
    )
  )
  
  (iter items '())
)

; This doesn't work either.

(square-list2 (list 1 2 3 4)) ; Should return '((((() . 1) . 4) . 9) . 16)

; In this case, the problem is that `cons` should take as its first argument
; an elelemnt and as its second argument a list, to add the element to the list.

; Here, Louis is swapping this order, so we are adding an element (a list) to a list of one element