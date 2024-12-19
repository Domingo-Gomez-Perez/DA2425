#lang racket
(define param 0)
(define (f x)
  (if (= param 1)
      (begin
        (set! param 0)
        x)
      (begin
        (set! param 1)
        0)
      )
  )

(+ (f 0) (f 1))
(+ (f 1) (f 0))
(+ (f 0) (f 1))
(+ (f 1) (f 0))