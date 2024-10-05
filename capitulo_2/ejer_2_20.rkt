#lang racket

(define (same-parity x . elements)
  (define (same-parity-iter x mylist result-list correct-parity?)
    (if (null? mylist) result-list
        (if (correct-parity? (car mylist)) (cons (car mylist) (same-parity-iter x (cdr mylist) result-list correct-parity?))
            (same-parity-iter x (cdr mylist) result-list correct-parity?))))
  (cons x (same-parity-iter x elements (list) (if (even? x) even? odd?))))


(same-parity 1 2 3 4 5 6 7) ; ->(1 3 5 7)

(same-parity 2 3 4 5 6 7) ; ->(2 4 6)