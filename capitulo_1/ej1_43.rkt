#lang racket

;EJERCICIO 1.43
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (square x) (* x x))

(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)  ; Función identidad
      (let loop ((count n) (result (lambda (x) x)))
        (if (= count 0)
            result
            (loop (- count 1) (compose f result))))))

((repeated square 2) 5) 