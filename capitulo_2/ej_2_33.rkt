#lang racket

; Exercise 2.33

; Fill in the missing expressions to complete the following
; definitions of some basic list-manipulation operations as accumulations:

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))


; Map
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

; Append
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

; Length
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))


; Tests:
(map (lambda (x) (+ x x)) (list 1 2 3 4))   ; Should return '(2 4 6 8)
(append (list 1 2 3 4) (list 5 6 7 8))      ; Should return '(1 2 3 4 5 6 7 8)
(length (list 1 2 3 4 5 6 7 88))            ; Should return 8