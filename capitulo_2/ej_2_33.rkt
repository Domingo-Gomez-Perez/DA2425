#lang racket

; Definicion de accumulate
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

; Definicion de map
(define (map2 p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) 
              '() 
              sequence))

; Definicion de append
(define (append2 seq1 seq2)
  (accumulate cons seq2 seq1))

; Definicion de lenght
(define (length2 sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

; Ejemplos:

(map2 sqr '(1 2 3 4)) ; Deberia devolver (1 4 9 16)

(append2 '(1 2 3) '(4 5 6)) ; Deberia devolver (1 2 3 4 5 6)

(length2 '(1 2 3 4 5)) ; Deberia devolver 5