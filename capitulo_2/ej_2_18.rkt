#lang racket
(define (reverse lista)
  (if (null? (cdr lista))
      lista
      (append (reverse (cdr lista)) (list(car lista)))))

(reverse (list 1 2 3 4))