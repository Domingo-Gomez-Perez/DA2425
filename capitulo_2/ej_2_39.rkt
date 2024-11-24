#lang racket
;Ejercicio 2.39
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op 
                      initial 
                      (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (reverseI sequence)
  (fold-right 
   (lambda (x y) (append y(list x))) null sequence))

(reverseI (list 1 2 3))

(define (reverseII sequence)
  (fold-left 
   (lambda (x y) (cons y x)) null sequence))

(reverseII (list 1 2 3))