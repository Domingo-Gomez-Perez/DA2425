#lang racket
(define (last-pair lista)
   (if (null? (cdr lista))
       lista
       (last-pair (cdr lista))
       )
  )

(define l (list 1 2 3 4 5))
(last-pair l)