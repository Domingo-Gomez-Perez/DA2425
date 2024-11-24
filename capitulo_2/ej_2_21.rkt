#lang racket
;Ejercicio 2.21

(define (square-listI items)
  (if (null? items)
      null
      (cons (*(car items)(car items)) (square-listI (cdr items)))))

(square-listI (list 1 2 3 4))

(define (square-listII items)
  (map (lambda (x) (* x x)) items))

(square-listII (list 1 2 3 4))