#lang racket
(define (last-pair lista)
  (if (= (length lista) 1)
      (car lista)
      (last-pair (cdr lista))))


(define (length s)
    (if (null? s)
        0
	(+ 1 (length (cdr s)))))

(last-pair (list 23 72 149 34 22))