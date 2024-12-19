#lang racket
(define (equal? a b)
  (cond
    ((and (symbol? a) (symbol? b)) (eq? a b))       ;ambos son símbolos
    ((and (number? a) (number? b)) (= a b))          ;ambos son números
    ((and (pair? a) (pair? b))                       ;ambos son listas (pares)
     (and (equal? (car a) (car b))
          (equal? (cdr a) (cdr b))))
    ((and (null? a) (null? b)) #t)                   ;ambos son listas vacías
    (else #f)))                                      ;no son iguales

(equal? '(this is a list) '(this is a list))
;Resultado: #t

(equal? '(this is a list) '(this (is a) list))
;Resultado: #f

(equal? '(1 2 3) '(1 2 3))
;Resultado: #t

(equal? '() '())
;Resultado: #t
