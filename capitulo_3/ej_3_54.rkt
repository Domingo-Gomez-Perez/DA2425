#lang racket

(define (stream-map2 proc x y)
  (if (stream-empty? x)
      empty-stream
      (stream-cons (proc (stream-first x) (stream-first y))
                   (stream-map2 proc (stream-rest x) (stream-rest y)))))


(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))


(define (mul-streams s1 s2) 
  (stream-map2 * s1 s2))

(define factorials 
  (stream-cons 1 (mul-streams factorials (integers-starting-from 1))))

;Ejemplos
(stream-ref factorials 1);1
(stream-ref factorials 2);2
(stream-ref factorials 3);6
(stream-ref factorials 4);24
(stream-ref factorials 5);120