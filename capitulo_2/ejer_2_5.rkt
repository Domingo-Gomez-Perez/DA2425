#lang racket

(define (fast-expt b n)
  (define (square x) (* x x))
  (define (even? n)
    (= (remainder n 2) 0))
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1)))))) ;En realidad este no es el fast-expt más fast, pero bueno


(define (cons a b)
  (* (fast-expt 2 a) (fast-expt 3 b)))

(define (cdr x)
  (define (cdr-iter x b)
    (if (odd? x)
        (if (= x 3) b (cdr-iter (/ x 3) (+ b 1)))
        (cdr-iter (/ x 2) b)))
  (cdr-iter x 1))

(cdr (cons 2 3))


(define (car x)
  (define (car-iter x a)
    (if (not (= 0 (remainder x 3)))
        (if (= x 2) a (car-iter (/ x 2) (+ a 1)))
        (car-iter (/ x 3) a)))
    (car-iter x 1))

(car (cons 2 3))



(define (iter x n divided-product? found-expt? unwanted-multiplier wanted-multiplier)
    (if (divided-product? x)
        (if (found-expt?) n (iter (/ x wanted-multiplier) (+ n 1)))
        (iter (/ x unwanted-multiplier) n)))

(define (first?-cdr x) (not (= 0 (remainder x 2))))
(define (second?-cdr x) (= x 3))

(define (cdr2 x)
  (iter x 1 first?-cdr second?-cdr 2 3))

(cdr (cons 2 3))

(define (first?-car x) (not (= 0 (remainder x 3))))
(define (second?-car x) (= x 2))

(define (car2 x)
  (iter x 1 first?-car second?-car 3 2))

(car (cons 2 3))
