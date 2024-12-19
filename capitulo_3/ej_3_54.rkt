#lang racket

; Exercise 3.54

; Define a procedure `mul-streams`, analogous to `add-streams`, 
; that produces the elementwise product of its two input streams. 

(define (mul-streams s1 s2)
  (if (stream-empty? s1)
      empty-stream
      (stream-cons (* (stream-first s1) (stream-first s2))
                   (mul-streams (stream-rest s1) (stream-rest s2)))))


; Auxiliary methods

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))


; Example of use

(define s1 (stream 1 2 3 4 5))
(define s2 (stream 10 20 30 40 50))
(define mul (mul-streams s1 s2))

(display "Mult")
(display-stream mul)
(newline)





; Use this together with the stream of `integers` to complete the
; following definition of the stream whose nth element (counting
; from 0) is `n + 1` factorial:


; Auxiliary methods

(define (add-stream s1 s2)
  (if (stream-empty? s1)
      empty-stream
      (stream-cons (+ (stream-first s1) (stream-first s2))
                   (add-stream (stream-rest s1) (stream-rest s2)))))

(define (display-stream-n s n)
  (when (and (not (stream-empty? s)) (> n 0))
    (display (stream-first s))
    (newline)
    (display-stream-n (stream-rest s) (- n 1))))

(define ones (stream-cons 1 ones))
(define integers (stream-cons 1 (add-stream ones integers)))


; Example of use

(define factorials (stream-cons 1 (mul-streams integers factorials)))

(newline)
(displayln "Factorial")

; To see more numbers, change the 9 to another index:
(display-stream-n factorials 9)