#lang racket
(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (car int)
 (car-aux int 0))

(define (car-aux int a)
    (if (even? int) (car-aux (/ int 2) (+ a 1)) a))

(define (cdr int)
 (cdr-aux int 0))

(define (cdr-aux int b)
    (if (= (remainder int 3) 0) (cdr-aux (/ int 3) (+ b 1)) b))