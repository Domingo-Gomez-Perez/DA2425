#lang racket
(define (make-monitored )
  (let ([]
        [])
    (lambda (x)
      (set! valor (+ valor x))
      valor)
  )
)

(define s (make-monitored sqrt))

(s 100)
;10

(s 'how-many-calls?)
;1