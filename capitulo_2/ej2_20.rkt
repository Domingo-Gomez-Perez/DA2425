#lang racket
(define (same-parity x . y)
  (define (same-parity-helper numbers result)
    (cond
      ((null? numbers) result)
      ((= (modulo (car numbers) 2) (modulo x 2))
       (same-parity-helper (cdr numbers) (cons (car numbers) result)))
      (else
       (same-parity-helper (cdr numbers) result))))
  (reverse (same-parity-helper (cons x y) '())))


(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)
