#lang racket
;Exercise 1.31:

;The sum procedure is only the simplest of a vast number of similar abstractions that can be captured as higher-order procedures.
;Write an analogous procedure called product that returns the product of the values of a function at points over a given range.
;Show how to define factorial in terms of product. Also use product to compute approximations to pi using the formula
;pi   2 * 4 * 4 * 6 * 6 * 8 ...
;-- = -------------------------
; 4   3 * 3 * 5 * 5 * 7 * 7 ...
;If your product procedure generates a recursive process, write one that generates an iterative process.
;If it generates an iterative process, write one that generates a recursive process.

;Procedure product basado en sum
(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define (igual x) x)
(define (siguiente x) (+ x 1))

;Probamos que funciona
(product igual 1 siguiente 5)

;Definimos factorial en funcion de product
(define (factorial n) (product igual 1 siguiente n))

;Probamos que funciona
(factorial 5)

;Como mi product es recursivo y lo hare iterativo
(define (product-ite term a next b total)
  (if (> a b)
      total
      (product-ite term (next a) next b (* total (term a)))))

(product-ite igual 1 siguiente 5 1)

;Usamos product para hacer approximaciones de pi

; Genera el siguiente valor
(define (siguientepar x) (+ x 2))


;Elegimos un valor par muy alto para que actue como infinito, y por tanto un impar 1 menos
(define pi (* (/
           (* (product igual 2 siguientepar 111998 ) (product igual 4 siguientepar 112000))
           (* (product igual 3 siguientepar 111999 ) (product igual 3 siguientepar 111999))) 4.0)
  )

(display pi)
(newline)

