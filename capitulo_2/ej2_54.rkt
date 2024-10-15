#lang racket
; equal? solo para símbolos
; pre: s1 y s2 deben ser listas del mismo tamaño
(define (equal? s1 s2)
  (if (null? s1)
      #t
      (if (eq? (car s1) (car s2))
          (equal? (cdr s1) (cdr s2))
          #f)))

; equal? para símbolos y números
(define (equal-advanced? s1 s2)
  (define (same? x y)
    (cond ((and (symbol? x) (symbol? y)) (eq? x y))
          ((and (number? x) (number? y)) (= x y))
          (else #f)))
  (if (null? s1)
      #t
      (if (same? (car s1) (car s2))
          (equal-advanced? (cdr s1) (cdr s2))
          #f)))


; comprobar equal? simple
(equal? '(this is a list) 
        '(this is a list)) ; -> #t

(equal? '(this is a list) 
        '(this (is a) list)) ; -> #f

; comprobar equal-advanced
(equal-advanced? '(this is a list) 
        '(this is a list)) ; -> #t
(equal-advanced? '(this is a list) 
        '(this (is a) list)) ; -> #f
(equal-advanced? '(1 2 a b 3)
                 '(1 2 a b 3)) ; #t
(equal-advanced? '(1 2 a c 3)
                 '(1 2 a b 3)) ; #f
