#lang racket
(define (make-accumulator initial-value)
  (let ([valor initial-value])
    (lambda (x)
      (set! valor (+ valor x))
      valor)
  )
)

;probar con dispatch

(((make-accumulator 5) 10) 10)


(define A (make-accumulator 5))


(A 10)
;15

(A 10)
;25