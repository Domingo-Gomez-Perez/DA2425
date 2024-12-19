#lang racket
(define (equal? lista1 lista2)
  (if (not(eq? (car lista1) (car lista2)))
      #f
      (if (and (eq? (cdr lista1) null)  (eq? (cdr lista1) null))
          #t
          (equal? (cdr lista1) (cdr lista2))
      ))
  

  )

(equal? '(this is a list) 
        '(this is a list))

(equal? '(this is a list) 
        '(this (is a) list))