#lang racket
(define (deep-reversa mylist)
  (define (deep-reversa-iter mylist result)
    (cond ((null? mylist)  result)
          ((not (pair? mylist))  mylist)
          ((if (pair? (car mylist))               
               (deep-reversa-iter (cdr mylist) (cons (deep-reversa-iter (car mylist) null) result))
               (if (null? (cdr mylist))
                   (cons (car mylist) result)
                   (deep-reversa-iter (cdr mylist) (cons (car mylist) result)))))))

  (deep-reversa-iter mylist null))

(deep-reversa (list (list 1 2) (list 3 4)))