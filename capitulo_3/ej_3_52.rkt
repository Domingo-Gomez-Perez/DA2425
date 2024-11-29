#lang racket

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))11
  sum)

; Crea una lista tipo stream de tamaño stop-start
(define (stream-enumerate-interval start stop)
  (if (> start stop)
      empty-stream
      (stream-cons start 
                   (stream-enumerate-interval (+ start 1) stop))))

(define seq 
  (stream-map 
   accum
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))

(define (stream-car stream) (stream-first stream))
(define (stream-cdr stream) (force (stream-rest stream)))

(define (display-stream s)
  (if (null? s) null
      (if (stream-empty? s) '()
          (begin (display (stream-car s))
                 (newline)
                 (display-stream (stream-cdr s))))))

(stream-ref y 7)
(display-stream z)