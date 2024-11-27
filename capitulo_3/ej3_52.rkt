#lang racket
(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))

(define (display-stream s)
     (if (stream-empty? s) null
         (begin (display (stream-first s))
                (newline)
                (display-stream (stream-rest s)))))

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
(display-stream z)


; Comienza en 
