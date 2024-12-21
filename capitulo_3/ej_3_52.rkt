#lang racket

(define (stream-car stream) (stream-first stream))
(define (stream-cdr stream) (force (stream-rest stream)))

(define (display-stream s)
     (if (null? s) null
         (if (stream-empty? s) '()
                (begin(display (stream-car s))
                      (newline)
                      (display-stream (stream-cdr s))))))



(define (stream-enumerate-interval low high)
  (if (> low high)
      empty-stream
      (stream-cons
       low
       (stream-enumerate-interval (+ low 1)
                                  high))))

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq 
  (stream-map 
   accum 
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))

(stream-ref y 7)
(display-stream z)