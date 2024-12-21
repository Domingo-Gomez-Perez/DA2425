#lang racket
(define (my-equal? element1 element2)
  (define (my-type-equal? list1 list2)
  (cond ((and (null? list1) (null? list2))  #t)
        ((or (null? list1) (null? list2))  #f)
        (else  (cond ((eq? (car list1) (car list2))  (my-type-equal? (cdr list1) (cdr list2)))
                     (else  #f)
                     )
               )
        )
  )
  
  (cond ((and (number? element1) (number? element2))  (= element1 element2))
        ((not (boolean=? (list? element1) (list? element2)))  #f)
        (else  (my-type-equal? element1 element2))
        )
  )


(my-equal? '(this is a list) 
        '(this (is a) list))

(my-equal? '(this is a list) 
        '(this is a list))

(equal? 1 1)

(my-equal? 1 1)

(my-equal? 1 '1)

(my-equal? 1 null)

(define a 2)
(define b 2)
(my-equal? a b)