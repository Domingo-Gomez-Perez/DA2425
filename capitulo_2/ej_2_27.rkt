#lang racket
;Ejercicio 2.27
(define (reverse list)
  (define (a list1 list2)
    (if (null? list1)
        list2
        (a (cdr list1) (cons (car list1) list2))))
  (a list '()))


(define (deep-reverse list)
  (define (a list1 list2)
   (cond ((null? list1)
          list2)
         ((pair? (car list1))
          (a (cdr list1) (cons (deep-reverse (car list1)) list2)))
         (else
          (a (cdr list1) (cons (car list1) list2)))))
  (a list '()))


(define x 
  (list (list 1 2) (list 3 4)))

x
;((1 2) (3 4))

(reverse x)
;((3 4) (1 2))

(deep-reverse x)
;((4 3) (2 1))