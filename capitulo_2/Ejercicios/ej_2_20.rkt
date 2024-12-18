#lang racket
(define (same-parity first . rest)
  (define (same-parity-helper lst)
    (filter (lambda (x) (= (modulo x 2) (modulo first 2))) lst))
  (cons first (same-parity-helper rest)))

(same-parity 1 2 3 4 5 6 7)
;Resultado: (1 3 5 7)

(same-parity 2 3 4 5 6 7)
;Resultado: (2 4 6)
