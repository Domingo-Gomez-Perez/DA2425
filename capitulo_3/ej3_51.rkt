#lang racket
(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))

(define (show x)
  (displayln x)
  x)

(define x 
  (stream-map 
   show 
   (enumerate-interval 0 10)))

(stream-ref x 5)
(stream-ref x 7)
