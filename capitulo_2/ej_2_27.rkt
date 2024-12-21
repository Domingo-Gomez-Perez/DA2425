#lang racket
(define (deep-reverse mylist)
  (define (deep-reverse-iter mylist result)
    (cond ((null? mylist)  result)
          ((not (pair? mylist))  mylist)
          ((if (pair? (car mylist))               
               (deep-reverse-iter (cdr mylist) (cons (deep-reverse-iter (car mylist) null) result))
               (if (null? (cdr mylist))
                   (cons (car mylist) result)
                   (deep-reverse-iter (cdr mylist) (cons (car mylist) result)))))))

  (deep-reverse-iter mylist null))

(deep-reverse (list 1 2 3 4 5))
(deep-reverse (list (list 1 2 3) 4 5))
(deep-reverse (list (list)))
(deep-reverse (list))
(deep-reverse (list (list 1 2) (list 3 4)))
(deep-reverse (list (list 1 (list 2)) 3 4 5)) ;((1 (2)) 3 4 5) -> (5 4 3 ((2) 1))