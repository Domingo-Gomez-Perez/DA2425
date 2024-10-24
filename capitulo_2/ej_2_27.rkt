#lang racket

; Exercise 2.27

; Modify your `reverse` procedure of Exercise 2.18 to produce a `deep-reverse` procedure
; that takes a list as argument and returns as its value the list with its
; elements reversed and with all sublists deep-reversed as well.

(define (reverse lst)
    (if (null? lst)
        lst
	(append (reverse (cdr lst)) (list (car lst)))))

(define (deep-reverse lst)
  (if (null? lst)
      null
      (append (deep-reverse (cdr lst)) (list (if (pair? (car lst))
                                                 (deep-reverse (car lst))
                                                 (car lst))))
   )
)

; Tests:
(define x
  (list (list 1 2) 5 6 (list 3 4) 9))

x                ; Should return '((1 2) 5 6 (3 4) 9)
(reverse x)      ; Should return '(9 (3 4) 6 5 (1 2))
(deep-reverse x) ; Should return '(9 (4 3) 6 5 (2 1))