#lang racket
(define (same-parity a . z)
 (if (even? a)
     (only-even (cons a z))
     (only-odd (cons a z))
     )
)
(define (only-even list)
  (if (even? (car list))
    (cons (only-even (cdr list)) (car list))
    (only-even (cdr list))
  )
)

(define (only-odd list)
  (if (even? (car list))
    (only-even (cdr list))
    (cons (only-even (cdr list)) (car list))
  )
)


(same-parity 1 2 3 4 5 6 7)

(car (list 1 2 3 4))