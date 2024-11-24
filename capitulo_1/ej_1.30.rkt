#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 1.30: The following `sum` procedure generates a linear recursion:

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

The procedure can be rewritten so that the sum is performed iteratively.
Show how to do this by filling in the missing expressions in the following definition:

(define (sum term a next b)
  (define (iter a result)
    (if ⟨??⟩
        ⟨??⟩
        (iter ⟨??⟩ ⟨??⟩)))
  (iter ⟨??⟩ ⟨??⟩))
|#

; suma recursiva (la que tenemos)
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

; suma iterativa
(define (sum-iter term a next b)
  (define (sum-iter-cap a result) ; encapsulamos para black box
    (if (> a b) ; Caso base: si a es mayor que b, devolvemos el resultado acumulado (hemos acabado).
        result
        (sum-iter-cap (next a) (+ result (term a))))); Acumulamos el resultado de term a en result.
  (sum-iter-cap a 0)) ; empezamos con la suma en 0

; procecdimientos adicionales
(define (cube x) (* x x x))
(define (inc x) (+ x 2))

; pruebas
(sum cube 2 inc 6)
(sum-iter cube 2 inc 6)

