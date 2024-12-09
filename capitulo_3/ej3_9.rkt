#lang racket
; **Exercise 3.9:** Will discuss as a group.  In 1.2.1 we used the
; substitution model to analyze two procedures for computing factorials, a
; recursive version

(define (factorial-rec n)
  (if (= n 1)
      1
      (* n (factorial-rec (- n 1)))))

;and an iterative version

(define (factorial-iter n)
  (fact-iter 1 1 n))

(define (fact-iter product 
                   counter 
                   max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

; Show the environment structures created by evaluating `(factorial 6)`
; using each version of the `factorial` procedure.

(factorial-iter 3)
; Estructuras ambientales:
; 1º:
; global: factorial-iter; fact-iter
; factorial-iter: codigo | ambiente: n = 2, fact-iter
; fact-iter: codigo | ambiente: product = 1, counter = 1, max-count = 3

; 2º:
; global: factorial-iter; fact-iter
; factorial-iter: codigo | ambiente: n = 2, fact-iter
; fact-iter: codigo | ambiente: product = 1, counter = 2, max-count = 3 

; 3º:
; global: factorial-iter; fact-iter
; factorial-iter: codigo | ambiente: n = 2, fact-iter
; fact-iter: codigo | ambiente: product = 2, counter = 3, max-count = 3 

; 4º:
; global: factorial-iter; fact-iter
; factorial-iter: codigo | ambiente: n = 2, fact-iter
; fact-iter: codigo | ambiente: product = 6, counter = 4, max-count = 3 

; 5º:
; global: factorial-iter; fact-iter
; factorial-iter: codigo | ambiente: n = 2, fact-iter, resultado: 6





(factorial-rec 3)
; Estructuras ambientales:
; 1º:
; global: factorial-rec 
; factorial-rec 3: codigo | ambiente: n = 3; factorial-rec

; 2º:
; global: factorial-rec 
; factorial-rec 3: codigo | ambiente: n = 3; factorial-rec 
; factorial-rec 2: codigo | ambiente: n = 2; factorial-rec 

; 3º:
; global: factorial-rec 
; factorial-rec 3: codigo | ambiente: n = 3; factorial-rec 
; factorial-rec 2: codigo | ambiente: n = 2; factorial-rec
; factorial-rec 1: codigo | ambiente: n = 1;

; 4º:
; global: factorial-rec 
; factorial-rec 3: codigo | ambiente: n = 3; factorial-rec 
; factorial-rec 2: codigo | ambiente: n = 2; factorial-rec 
; factorial-rec 1: codigo | ambiente: n = 1; | resultado: 1

; 5º:
; global: factorial-rec 
; factorial-rec 3: codigo | ambiente: n = 3; factorial-rec 
; factorial-rec 2: codigo | ambiente: n = 2; | resultado: 2

; 6º:
; global: factorial-rec 
; factorial-rec 3: codigo | ambiente: n = 3; | resultado: 6



