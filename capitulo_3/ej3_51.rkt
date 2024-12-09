#lang racket

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

;Streams are interesting and weird.  Consider this example:

(define (display-stream s)
     (if (null? s) null
         (begin (display (stream-car s))
                (newline)
                (display-stream (stream-cdr s)))))

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

;Now, use these to solve the specific problem shown:

(define nums (enumerate-interval 1.0 5.0))
(define squares (stream-map (lambda (x) (* x x)) nums))
(define invsquares (stream-map (lambda (x) (/ 1.0 x)) squares))
;(stream-sum invsquares)

; **Exercise 3.51:** In order to take a closer look at
; delayed evaluation, we will use the following procedure, which simply returns
; its argument after printing it:

(define (show x)
  (displayln x)
  x)

; What does the interpreter print in response to evaluating each expression in
; the following sequence? [footnote](http://sarabander.github.io/sicp/html/3_002e5.xhtml#FOOT187)

(define x 
  (stream-map 
    show 
  (enumerate-interval 0 10)))

(stream-ref x 5)
(stream-ref x 7)
(stream-ref x 5)
(stream-ref x 7)
(stream-ref x 10)
(stream-ref x 5)
(stream-ref x 5)
