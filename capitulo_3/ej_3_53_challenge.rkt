#lang racket

; Exercise 3.53 Challenge

; Implement the `(add-stream s1 s2)` procedure without using stream-map.


; Auxiliary methods

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))



; Sum streams

(define (add-stream s1 s2)
  (if (stream-empty? s1)
      empty-stream
      (stream-cons (+ (stream-first s1) (stream-first s2))
                   (add-stream (stream-rest s1) (stream-rest s2)))))


(define s1 (stream 1 2 3 4 5))
(define s2 (stream 10 20 30 40 50))

(define sum (add-stream s1 s2))
(display-stream sum)

