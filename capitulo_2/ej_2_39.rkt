#lang racket
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

(define (reverse1 sequence)
  (fold-right
   (lambda (x y) (append sequence (list x))) null sequence))
   ;(lambda (x y) (reverse2 (cons y x))) null sequence))
   ;(lambda (x y) (fold-right (lambda (w z) (cons z w)) null (cons y x))) null sequence))

(define (reverse2 sequence)
  (fold-left 
   (lambda (x y) (cons y x)) null sequence))

(reverse1 (list 1 2 3 4 5))

(reverse2 (list 1 2 3 4 5))