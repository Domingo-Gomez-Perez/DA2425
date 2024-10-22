#lang racket

; **Exercise 1.31:**

; 1. The `sum` procedure is only the simplest of a vast number of similar
; abstractions that can be captured as higher-order procedures. Write an analogous
; procedure called `product` that returns the product of the values of a
; function at points over a given range.  Show how to define `factorial` in
; terms of `product`.  Also use `product` to compute approximations to
; `pi` using the formula

; ```
; pi   2 * 4 * 4 * 6 * 6 * 8 ...
; -- = -------------------------
;  4   3 * 3 * 5 * 5 * 7 * 7 ...
; ```

; 2. If your `product` procedure generates a recursive process, write one that
; generates an iterative process.  If it generates an iterative process, write
; one that generates a recursive process.

(define (next x)
  (+ x 1))

; Versión recursiva de product
(define (product term a next b)
  (if (> a b)
      1                             ; Si el rango ha terminado, retornamos 1 (elemento neutro de la multiplicación).
      (* (term a)                   ; Multiplicamos el término actual por el resultado de los términos restantes.
         (product term (next a) next b))))  ; Usamos la función `next` para avanzar.

(define (factorial n)
  (product identity 1 next n))  ; Usa `next` en lugar de una lambda.

(factorial 5)  ; Resultado: 120

(define (pi-product n)
  (* 4
     (/ (product (lambda (x) (* x (+ x 2))) 2 (lambda (x) (+ x 2)) n)  ; Numerador
        (product (lambda (x) (* x x)) 3 (lambda (x) (+ x 2)) n))))     ; Denominador

(pi-product 10000)  ; Aproximación de pi. No funciona !!!!!!!

;Esta es la version iterativa de product:

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))
(define (factorial2 n)
  (product-iter identity 1 next n))

(factorial2 5)  ; Resultado esperado: 120, COnfirmado.





