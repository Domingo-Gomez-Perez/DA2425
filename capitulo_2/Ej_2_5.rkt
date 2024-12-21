#lang racket
; Ejercicio 2.5

(define (divide x y) (
   divide-rec x y 0
                      ))

(define (divide-rec x y i) (
   if (< (- x y) 0)
      i
      (divide-rec (- x y) y (+ i 1))
                            ))

(define (% x y) (
   if (= (divide x y) 0)
      x
      (% (- x y) y)
                 ))

(define (reduce-2 x) (
   reduce-2-rec x 0
                      ))

(define (reduce-2-rec x i) (
   if (= (% x 2) 0)
      (reduce-2-rec (divide x 2) (+ i 1))
      i

                            ))

(define (reduce-3 x) (
   reduce-3-rec x 0
                      ))

(define (reduce-3-rec x i) (
   if (= (% x 3) 0)
      (reduce-3-rec (divide x 3) (+ i 1))
      i
                            ))

(define (cons x)
  (lambda (m) (m (reduce-2 x) (reduce-3 x))))

(define (car z) 
  (z (lambda (p q) p)))

(define (cdr z) (
   z (lambda (p q) q)
                 ))

(car (cons 6))
(cdr (cons 6))

(car (cons 36))
(cdr (cons 36))

(car (cons 27))
(cdr (cons 27))