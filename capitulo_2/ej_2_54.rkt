#lang racket
(define (my-equal? element1 element2)
  (define (my-type-equal? list1 list2)
  (cond ((and (null? list1) (null? list2))  (void))
        ((or (null? list1) (null? list2))  (void))
        (else  (cond ((eq? (car list1) (car list2))  (my-type-equal? (cdr list1) (cdr list2)))
                     (else  (void))))))
  
  (cond ((and (number? element1) (number? element2))  (= element1 element2))
        ((not (boolean=? (list? element1) (list? element2)))  (void))
        (else  (my-type-equal? element1 element2))))


(equal? 1 1)

(define a 2)
(define b 2)
(my-equal? a b)