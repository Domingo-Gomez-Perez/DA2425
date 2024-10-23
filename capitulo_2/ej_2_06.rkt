#lang racket

; Exercise 2.6

; In case representing pairs as procedures wasn't mind-boggling enough, consider that, in a language that can
; manipulate procedures, we can get by without numbers (at least insofar as nonnegative integers are concerned) 
; by implementing 0 and the operation of adding 1 as

(define zero
  (lambda (f) (lambda (x) x)))

; def zero:
;    def f(x):
     

(define (add-1 n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))

; This representation is known as "Church numerals," after its inventor,
; Alonzo Church, the logician who invented the λ-calculus.

; Define `one` and `two` directly (not in terms of `zero` and `add-1`).

(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))


; Give a direct definition of the addition procedure `+` (not in terms of repeated application of `add-1`).
(define (church-add funct-num1 funct-num2)
  (lambda (f)
    (lambda (x)
      ((funct-num1 f) ((funct-num2 f) x)))))

; Example usage
(define three (church-add one two))


;-----------------------------------------------------;
; Este ejercicio son 0.25 puntos extra para el examen ;
;-----------------------------------------------------;

; Define the multiplication procedure `*` for Church numerals
(define (church-mul funct-num1 funct-num2)
  (lambda (f)
    (funct-num1 (funct-num2 f))))


; Tests
(define six (church-mul two three))
(define cero (church-mul zero three))

; To convert Church numerals to regular numbers for testing
(define (church-to-int funct-num)
  ((funct-num (lambda (x) (+ x 1))) 0))

(church-to-int zero) ; should return 0
(church-to-int one)  ; should return 1
(church-to-int two)  ; should return 2
(church-to-int three); should return 3
(church-to-int six)  ; should return 6
(church-to-int cero) ; should return 0