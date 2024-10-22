#lang racket
;Exercise 2.6: In case representing pairs as procedures wasn't mind-boggling enough, consider that, in a language that can manipulate procedures,
;we can get by without numbers (at least insofar as nonnegative integers are concerned) by implementing 0 and the operation of adding 1 as

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
;This representation is known as "Church numerals," after its inventor, Alonzo Church, the logician who invented the λ-calculus.

;Define one and two directly (not in terms of zero and add-1). (Hint: Use substitution to evaluate (add-1 zero)).
;Give a direct definition of the addition procedure + (not in terms of repeated application of add-1).

(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))


(define (inc x) (+ x 1))

;Funcion que realiza la suma
(define (church-add funct-num1 funct-num2)
  (lambda (f)
    (lambda (x)
      ((funct-num1 f) ((funct-num2 f) x)))))

;definicion de 3
(define three (church-add one two))

;Funcion que realiza la multiplicacion
;Al realizar este apartado seran 0,25 puntos en el examen
(define (church-mul funct-num1 funct-num2)
  (lambda (f)
    (funct-num1 (funct-num2 f))))

;definicion de 6
(define six (church-mul two three))

(((church-mul two three) inc) 0)

