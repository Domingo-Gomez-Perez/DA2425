#lang racket

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))
;Tenemos que hacer que la secuencia realice la p
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) 
              '() sequence))

;El append tiene que añadir una secuencia a la otra
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

;Length tiene que sumar 1
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

;Prueba de los ejercicios
(map (lambda (x) (* x x)) '(1 2 3 4))  ; => (1 4 9 16)
(append '(1 2 3) '(4 5 6))             ; => (1 2 3 4 5 6)
(length '(1 2 3 4 5))  