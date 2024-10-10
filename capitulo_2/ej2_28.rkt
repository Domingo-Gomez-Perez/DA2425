#lang racket
(define x 
  (list (list 1 (list 2 3 (list 4))) (list 5 6)))

(define (fringe t)
  (cond
    ((null? t) null)
    ((not (list? t)) (list t))
    (else (append (fringe (car t))
                  (fringe (cdr t))))))

(display x)
(newline)
(fringe x)          ; -> (1 2 3 4 5 6)
(fringe (list x x)) ; -> (1 2 3 4 5 6 1 2 3 4 5 6)
