#lang racket
(define (last-pair s)
  (if (null? (cdr s))
      s
      (last-pair (cdr s))))

(last-pair (list 23 72 149 34))
