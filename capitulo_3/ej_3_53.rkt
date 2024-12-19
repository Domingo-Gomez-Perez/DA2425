#lang racket
(require racket/stream)

(define (display-stream stream)
  (stream->list stream))

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define s (stream-cons 1 (add-streams s s)))
s

;Va duplicando el resultado anterior empezando en 1 -> 2 -> 4, etc, dando lugar a las potencias de 2 en el stream