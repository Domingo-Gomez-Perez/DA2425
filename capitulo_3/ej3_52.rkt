#lang racket

(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))

(define (display-stream s)
     (if (stream-empty? s)
         '()
         (begin (display (stream-first s))
                (newline)
                (display-stream (stream-rest s)))))


(define sum 0)

(define (accum x) 
  (set! sum (+ x sum))
  sum)

(define seq 
  (stream-map 
   accum 
   (enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))


(stream-ref y 7)
;sum = 136
;(posicion 7 del stream)

(display-stream z)
;Muestra los numeros divisibles entre 5 -> 10 15 45 55 105 120 190 210 '()
;sum = 210;


