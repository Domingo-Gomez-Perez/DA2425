#lang racket
(define (make-accumulator n)
  (define (add-to-accumulator x)
    (begin
      (set! n (+ n x))
      n
      )
    )
  add-to-accumulator
  )

(define A (make-accumulator 5))

(A 10)

(A 10)