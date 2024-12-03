#lang racket

; Definicion de fold-right
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op 
                      initial 
                      (cdr sequence)))))

; Definicion de fold-left
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

; Definicion usando fold-right
(define (reverse1 sequence)
  (fold-right 
   (lambda (x y) (append y (list x))) null sequence))

; Definicion usando fold-left
(define (reverse2 sequence)
  (fold-left 
   (lambda (x y) (cons y x)) null sequence))


; Ejemplos:

(define lista1 (list 1 4 9 16 25))

(reverse1 lista1) ; Deberia devolver (25 16 9 4 1) (metodo fold-right)

(reverse2 lista1) ; Deberia devolver (25 16 9 4 1)(metodo fold-left)