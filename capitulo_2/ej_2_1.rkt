#lang racket


(define (make-rat n d)
  (if (and (< d 0) (or (>= n 0)(< n 0)))
      (let ((g (gcd n d)))
    (cons (/ (* n -1) g) 
          (/ (* d -1) g)))
     (let ((g (gcd n d)))
    (cons (/ n g) 
          (/ d g))) ))
  



(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (numer r) (car r))

(define (denom r) (cdr r))

(make-rat 3 4)
(add-rat (cons 2 3) (cons 4 5))

