#lang racket

(define (abs x) (if (< x 0) (- x) x))
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat num den) ;No hago nada en caso de que el denominador sea 0
  (let ((n (abs num))
        (d (abs den)))
    (cond ((or (and (>= num 0) (>= den 0)) (and (<= num 0) (<= den 0)))
         (let ((g (gcd n d)))
           (cons (/ n g) (/ d g))))
        (else
         (let ((g (gcd n d)))
           (cons (- (/ n g)) (/ d g)))))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define numero (make-rat 3 4))
(print-rat numero)

(define numero2 (make-rat 8 4))
(print-rat numero2)

(define numero3 (make-rat 9 4))
(print-rat numero3)

(define numero4 (make-rat -9 4))
(print-rat numero4)

(define numero5 (make-rat -9 -4))
(print-rat numero5)