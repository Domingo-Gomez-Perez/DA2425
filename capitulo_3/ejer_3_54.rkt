#lang racket
(require racket/stream)

;(define s (stream-cons 1 (add-streams s s)))

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define ones (stream-cons 1 ones))
(define integers 
  (stream-cons 1 (add-streams ones integers)))

(define (mul-streams s1 s2) (stream-map * s1 s2))

(define factorials 
  (stream-cons 1 (mul-streams ⟨??⟩ ⟨??⟩)))