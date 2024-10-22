#lang racket
;Ejercicio 2.54

 (define (equal? list1 list2)
  (if (null? list1)
    #t
    (cond
      ((symbol? (car list1))
       (if (eq? (car list1) (car list2))
           (equal? (cdr list1) (cdr list2))
           #f))
      ((number? (car list1))
       (if (= (car list1) (car list2))
           (equal? (cdr list1) (cdr list2))
           #f))
      (else #f))))

(equal? '(this is a list) 
        '(this is a list))

(equal? '(this is a list) 
        '(this (is a) list))

(equal? '(21 32 43 43) 
        '(21 32 43 43))

(equal? '(1234) 
        '(1(23)4))
  
  
  