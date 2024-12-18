#lang racket
(for-each 
 (lambda (x) (newline) (display x))
 (list 57 321 88))

(define (for-each2 op lista)
  (cond
    ((null? lista) (void))
     (else
      (newline)
      (op (car lista))
      (for-each2 op (cdr lista)))))

(newline)
(for-each2 display (list 57 321 88))