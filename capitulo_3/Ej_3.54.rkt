#lang racket
(define ones (stream-cons 1 ones))

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define (mul-streams s1 s2) 
  (stream-map * s1 s2))

(define integers 
  (stream-cons 1 (add-streams ones integers)))

(define factorials 
  (stream-cons 1 (mul-streams mul-streams factorials integers)))