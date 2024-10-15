#lang racket

(define (for-each1 f mylist)
  (if (null? mylist) #f
      (f (car mylist)))
      (for-each f (cdr mylist)))

(for-each1 
(lambda (x) (newline) (display x))
(list 57 321 88))