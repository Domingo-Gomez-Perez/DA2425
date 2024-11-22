#lang racket

(define (same-parity x . rest)
  (define (same-parity-helper first lst)
    (filter (lambda (n) (= (modulo n 2) (modulo first 2))) lst))
  (cons x (same-parity-helper x rest)))

(same-parity 1 2 3 4 5 6 7)
;;'(1 3 5 7)

(same-parity 2 3 4 5 6 7)
;;'(2 4 6)