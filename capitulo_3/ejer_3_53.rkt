#lang racket
(require racket/stream)

(define (display-stream stream)
  (stream->list stream))

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define s (stream-cons 1 (add-streams s s)))

;Los elementos se irán evaluando como: 1+1=2, (1+1)+(1+1) = 2+2 = 4, 4+4 = 8, 8+8 = 16... Generará un stream infinito con las potencias de 2.