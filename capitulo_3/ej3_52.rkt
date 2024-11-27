#lang racket
;Streams are interesting and weird.  Consider this example:

(define (display-stream s)
     (if (stream-empty? s) '()
         (begin (display (stream-first s))
                (newline)
                (display-stream (stream-rest s)))))

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


; **Exercise 3.52:** One common optimization of streams is that of
; "memoization."  When the delayed part of a stream is evaluated, the
; the result is cached or memorized for later.  This can avoid repeated
; operations.  This exercise explores that idea.

; Consider the sequence of expressions

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
(display "done\n")
(display-stream z)


; What is the value of `sum` after each of the above expressions is
; evaluated?  What is the printed response to evaluating the `stream-ref`
; and `display-stream` expressions?  Would these responses differ if we had
; implemented `(delay ⟨exp⟩)` simply as `(lambda () ⟨exp⟩)`
; without using the optimization provided by `memo-proc`?  Explain.


;Despues de evaluar las expresiones anteriores, sum = 210
;(stream-ref y 7)->136
;(display-stream z)-> 10 15 45 55 105 120 190 210 '()
