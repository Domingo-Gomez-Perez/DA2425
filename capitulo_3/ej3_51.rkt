#lang racket

(define (show x)
  (displayln x)
  x)

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

(define (stream-sum s)
    (if (stream-empty? s)
        0
	(+ (stream-first s) (stream-sum (stream-rest s)))))

(define x 
  (stream-map 
   show 
   (enumerate-interval 0 10)))

(stream-ref x 5)
;Los elementos previos al indice 5 no se imprimen, pero al llegar al quinto elemento
;la funcion "show" se aplica sobre este elemento, imprimiento su valor (5)
(stream-ref x 7)
;Los elementos previos al indice 7 no se imprimen, pero al llegar al quinto elemento
;la funcion "show" se aplica sobre este elemento, imprimiento su valor (7)
