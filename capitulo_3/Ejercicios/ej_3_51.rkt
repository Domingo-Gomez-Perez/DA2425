#lang racket
(define (show x)
  (displayln x)
  x)


(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))


(define x
  (stream-map
   show 
  (enumerate-interval 0 10)))


(stream-ref x 5)
(stream-ref x 7)

; Ejecuta show con el valor asignado lo que ejecuta show con 5 y con 7 respectivamente