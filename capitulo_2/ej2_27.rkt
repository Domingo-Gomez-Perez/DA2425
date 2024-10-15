#lang racket
(define x 
  (list (list 1 2) (list 3 4) (list 5 (list 6 (list 7 8) 9))))

; reverse
(define (reverse s)
  (if (null? s)
      null
      (append (reverse (cdr s)) (list (car s)))))

; deep-reverse
(define (deep-reverse s)
  (if (null? s)
      null
      (append (deep-reverse (cdr s))
              (list (if (list? (car s))
                  (deep-reverse (car s))
                  (car s))))))

(display x)
(newline)
(reverse x)      ; -> '((5 (6 (7 8) 9)) (3 4) (1 2))
(deep-reverse x) ; -> '(((9 (8 7) 6) 5) (4 3) (2 1))

