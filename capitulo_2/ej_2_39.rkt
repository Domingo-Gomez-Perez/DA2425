#lang racket
;Exercise 2.39: Complete the following definitions of reverse (Exercise 2.18) in terms of fold-right and fold-left from Exercise 2.38.

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

;Fold-right recorre la lista de derecha a izquierda, entonces la operacion une x a y(derecha de x)
;(append null (list 4)) → (4)
;(append (4) (list 2)) → (4 2)
;etc
(define (reverse sequence)
  (fold-right 
   (lambda (x y) (append y (list x))) null sequence))

;Fold-left recorre de izquierda a derecha, por tanto va uniendo por la izquierda
;(cons 3 null) → (3)
;(cons 2 (3)) → (2 3)
(define (reverse2 sequence)
  (fold-left 
   (lambda (x y) (cons y x)) null sequence))

(reverse (list 1 2 2 4))

(reverse2 (list 3 2 6 9))