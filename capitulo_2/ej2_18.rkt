#lang racket
(define (reverse s)
  (if (null? s)
      null
      (append (reverse (cdr s)) (list (car s)))))
      
(reverse (list 1 4 9 16 25))
