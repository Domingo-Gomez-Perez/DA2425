#lang racket
;Ejercicio 3.51
(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))

(define (stream-map proc s)
    (if (stream-empty? s) 
        empty-stream
        (stream-cons (proc (stream-first s))
                     (stream-map proc (stream-rest s)))))

(define (show x)
  (displayln x)
  x)

(define x 
  (stream-map 
   show 
   (enumerate-interval 0 10)))
;enumerate-interval define un stream con los números del 0 al 10
;stream-map aplica show de forma a cada elemento de este stream

(stream-ref x 5)
;Este procedimiento evalua el stream hasta llegar
;al quinto elemento (índice 5), ejecutando show para el elemento 5.

(stream-ref x 7)
;Este procedimiento evalua el stream hasta llegar
;al septimo elemento (índice 7), ejecutando show para el elemento 7.
