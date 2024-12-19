#lang racket
(define (car x)
  (car-aux x 0)
  )

(define (car-aux x a) 
  (if (even? x) 
      (car-aux (quotient x 2) (+ a 1))
      a
      )
  )

(define (cdr x)
  (cdr-aux x 0)
  )

(define (cdr-aux x a) 
  (if (= (remainder x 3) 0)
      (cdr-aux (quotient x 3) (+ a 1))
      a
      )
  )

(define (cons x)
  (list (car x) (cdr x))
  )


(cons 18)
(cons 27)
