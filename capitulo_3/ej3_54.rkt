#lang racket

(define (stream-from n)
  (stream-cons n (stream-from (+ n 1))))

(define (mul-streams s1 s2)
  (stream-cons 
    (* (stream-first s1) (stream-first s2))
    (mul-streams (stream-rest s1) (stream-rest s2))))

(define integers (stream-from 1))

(define factorials 
  (stream-cons 1 
               (mul-streams integers factorials)))

(stream-ref factorials 3)
(stream-ref factorials 6)