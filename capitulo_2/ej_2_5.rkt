#lang racket


#|
**Exercise 2.5:** Show that we can represent pairs of
nonnegative integers using only numbers and arithmetic operations if we
represent the pair `a` and `b` as the integer that is the product `2^a * 3^b`.
Give the corresponding definitions of the procedures `cons`,
`car`, and `cdr`.
|#


;ir dividiendo entre 2 y entre 3 y en caso de que no se pueda dividir por ninguno en la primera iteracion, devuelve una lista (0,0)
;además en cada iteración va aumentando a y b
(define (cons z)
  (define (cons-iter a b z)
    (cond
      ((= z 1) (list a b))
      ((even? z) (cons-iter (+ a 1) b (quotient z 2)))
      ((= (remainder z 3) 0) (cons-iter a (+ b 1) (quotient z 3)))
      (else #f)))
  (cons-iter 0 0 z))

(define (car z)
  (define (cons-iter a z)
    (cond
      ((= z 1) a)
      ((even? z) (cons-iter (+ a 1) (quotient z 2)))
      ((= (remainder z 3) 0) (cons-iter a (quotient z 3)))
      (else #f)))
  (cons-iter 0 z))

(define (cdr z)
  (define (cons-iter b z)
    (cond
      ((= z 1) b)
      ((even? z) (cons-iter b (quotient z 2)))
      ((= (remainder z 3) 0) (cons-iter (+ b 1) (quotient z 3)))
      (else #f)))
  (cons-iter 0 z))


(cons 23)

(car 24)

(cons 48)


(cdr 18)