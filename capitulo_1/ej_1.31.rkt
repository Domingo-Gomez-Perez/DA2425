#lang racket

; Hecho por:
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Exercise 1.31:

The `sum` procedure is only the simplest of a vast number of similar abstractions 
that can be captured as higher-order procedures. Write an analogous procedure called 
`product` that returns the product of the values of a function at points over a given range.

Show how to define `factorial` in terms of `product`. Also, use `product` to compute 
approximations to pi using the formula:

        pi   2 * 4 * 4 * 6 * 6 * 8 ...
        -- = -------------------------
        4    3 * 3 * 5 * 5 * 7 * 7 ...

If your `product` procedure generates a recursive process, write one that generates 
an iterative process. If it generates an iterative process, write one that generates 
a recursive process.
|#

; producto recursivo
(define (product_rec term a next b)
  (if (> a b)
      1
      (* (term a)
         (product_rec term (next a) next b))))

; producto iterativo
(define (product_iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

; pruebas
(define (square x) (* x x))
(define (inc x) (+ x 2))

(product_rec square 2 inc 4)
(product_iter square 2 inc 4)

;Aproximacion de pi  (escribir la formula tal cual)
(define (pi-aprox n)
  (* 4
     (/
      (* 2 (product_iter square 4 inc n))
      (* n (product_iter square 3 inc (- n 1))))))

(pi-aprox 24)

