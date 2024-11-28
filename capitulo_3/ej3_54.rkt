#lang racket
(define (stream-map proc . ss)
  (if (stream-empty? (car ss))
      empty-stream
      (stream-cons (apply proc (map stream-first ss))
                   (apply stream-map proc (map stream-rest ss)))))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define factorials
  (stream-cons 1 (mul-streams factorials (integers-starting-from 2))))

(stream-ref factorials 2) ; ->   6 = 3! = (2+1)!
(stream-ref factorials 5) ; -> 720 = 6! = (5+1)!
