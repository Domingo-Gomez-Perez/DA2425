#lang racket
(define (reverse lista)
  (if (null? (cdr lista))
      (car lista)
      (reverse-aux (cdr lista) (list (list-ref lista 0)))
      )
  )

(define (reverse-aux lista new-list)
  (if (null? (cdr lista))
      (cons (list-ref lista 0) new-list)
      (reverse-aux (cdr lista) (cons (list-ref lista 0) new-list))
      )
  )

(define l (list 1 2 3 4 5))
(reverse l)