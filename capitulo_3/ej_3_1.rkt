#lang racket

(define (make-accumulator valor)
  (define (acumulador acumula)
    (begin
      (set! valor (+ valor acumula))
      valor))  
  acumulador
  )

(define A (make-accumulator 5))

(A 10)


(A 10)
