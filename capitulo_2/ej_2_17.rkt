#lang racket

(define (last-pair lista)
  (if (>= (length lista) 2)
       (last-pair (cdr lista))
       lista
  )
)

(last-pair (list 1 2 3 4 5 6))