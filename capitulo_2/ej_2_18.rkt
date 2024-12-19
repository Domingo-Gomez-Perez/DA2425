#lang racket
(define (reverse mylist)  
  (define (reverse-iter mylist result-list)
    (if (null? (cdr mylist)) (cons (car mylist) result-list)
        (reverse-iter (cdr mylist) (cons (car mylist) result-list))))

  (reverse-iter mylist null))

(reverse (list 1 2 3 4 5))
(reverse (list 1))
;(reverse (list)) Da error

;Este algoritmo tiene complejidad lineal
