#lang racket
(define (last-pair lista)
  (if (null? (cdr lista))
      (car lista)
      (last-pair (cdr lista)))
  )

(last-pair '(1,2,3,4,5))