#lang racket
(require racket/stream)

(define (show x)
  (displayln x)
  x)

(define (stream-enumerate-interval low high)
  (if (> low high)
      '()
      (stream-cons 
       low
       (stream-enumerate-interval (+ low 1)
                                  high))))

(define x 
  (stream-map 
   show 
   (stream-enumerate-interval 0 10)))

(stream-ref x 5)
(stream-ref x 5)

(stream-first (stream-rest (stream-rest x)))