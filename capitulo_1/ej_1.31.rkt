#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 1.31: The `sum` procedure is only the simplest of a vast number of similar abstractions
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

; lo unico que diferencia a la suma del producto, es que debe multiplicar
; y empezar en 1 para no multiplicar por 0

; fijandonos en los procedimientos anteriores:

; producto recursivo
(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

; producto iterativo
(define (product-iter term a next b)
  (define (product-iter-cap a result) ; encapsulamos para black box
    (if (> a b) ; Caso base: si a es mayor que b, devolvemos el resultado acumulado (hemos acabado).
        result
        (product-iter-cap (next a) (* result (term a))))); Acumulamos el resultado de term a en result.
  (product-iter-cap a 1)) ; empezamos con la multiplicacion a 1

; pruebas
(define (id x) x)
(define (square x) (* x x))
(define (inc x) (+ x 1))

(product square 2 inc 4)
(product-iter square 2 inc 4)

; ya vemos que funciona, ahora definamos factorial y pi

; factorial
(define (factorial n)
  (product id 1 inc n))

(factorial 5)


(define (pi-approximation n)
  (define (num-term x) (* 4 x x))         ; Numerador: 4 * x^2
  (define (denom-term x) (- (* 4 x x) 1)) ; Denominador: 4 * x^2 - 1
  (define (next x) (+ x 1))               ; Incremento de x

  (define (product-num n) (product num-term 1 next n))     ; Producto del numerador
  (define (product-denom n) (product denom-term 1 next n)) ; Producto del denominador

  ; Ahora calculamos pi (la fórmula da pi/2 así que multiplicamos por 2 el resultado)
  (* 2 (/ (product-num n) (product-denom n)))
  )

; Ejemplo de uso
(pi-approximation 200) ;  aproxima a 3.14159