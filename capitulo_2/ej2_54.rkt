#lang racket

(define (equal? a b)
  (cond
    ((and (number? a) (number? b)) (= a b))
    
    ((and (symbol? a) (symbol? b)) (eq? a b))
    
    ((and (pair? a) (pair? b))
     (and (equal? (car a) (car b)) 
          (equal? (cdr a) (cdr b))))
    
    ((and (null? a) (null? b)) #t)

    (else #f)))

(equal? '(this is a list) 
        '(this is a list))

(equal? '(this is a list) 
        '(this (is a) list))

(equal? '(21 32 43 43) 
        '(21 32 43 43))

(equal? '(1234) 
        '(1(23)4))

        