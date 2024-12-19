#lang racket
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (for-each func list)
  (accumulate func (car list) (cdr list))
  )

(for-each (lambda (x y) (* x y)) (list 1 2 3 4))