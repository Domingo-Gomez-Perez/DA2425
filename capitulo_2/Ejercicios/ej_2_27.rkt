#lang racket
(define x 
  (list (list 1 2) (list 3 4)))

(define (reverse lista)
  (define (reverse-iter lista lista-rev)
    (if (= (length lista) 0)
        lista-rev
        (reverse-iter (cdr lista) (cons (car lista) lista-rev))))
  (reverse-iter lista null))

(reverse x)

(define (deep-reverse lista)
  (define (deep-reverse-iter lista lista-rev)
    (if (null? lista)
        lista-rev
        (deep-reverse-iter (cdr lista)
                           (cons (if (list? (car lista))
                                     (deep-reverse (car lista))
                                     (car lista))
                                 lista-rev))))
  (deep-reverse-iter lista null))

(deep-reverse x)
(deep-reverse (list 2 6 (list 1 2) (list 3 4)))