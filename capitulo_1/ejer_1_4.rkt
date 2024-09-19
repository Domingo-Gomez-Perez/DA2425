#lang racket
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
;Cuando b es mayor que 0, a y b se suman, en caso contrario se restan