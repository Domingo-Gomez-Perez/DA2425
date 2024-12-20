#lang racket
; Ejercicio 3.53

(define (stream-map proc . argstreams)
  (if (null? (car argstreams))
      the-empty-stream
      (⟨??⟩
       (apply proc (map ⟨??⟩ argstreams))
       (apply stream-map
              (cons proc 
                    (map ⟨??⟩ 
                         argstreams))))))

(define (display-stream s)
  (stream-for-each displayln s))

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define s (stream-cons 1 (add-streams s s)))

(display-stream s)