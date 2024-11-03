#lang racket

; Exercise 2.39

; Complete the following definitions of `reverse` (Exercise 2.18)
; in terms of `fold-right` and `fold-left` from Exercise 2.38.


; Auxiliar methods
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




; Reverse using fold-right
(define (reverse-1 sequence)
  (fold-right
   (lambda (x y) (append y (list x)))
   '()
   sequence))

; Reverse using fold-left
(define (reverse-2 sequence)
  (fold-left
   (lambda (x y) (cons y x))
   '()
   sequence))


; Tests:
(reverse-1 (list 1 2 3 4 5 6))   ; Should return '(6 5 4 3 2 1)
(reverse-2 (list 1 2 3 4 5 6))   ; Should return '(6 5 4 3 2 1)