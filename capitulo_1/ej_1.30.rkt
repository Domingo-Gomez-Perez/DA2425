#lang racket

; Hecho por:
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Exercise 1.30:

The following `sum` procedure generates a linear recursion:

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

; suma recursiva
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

; suma iterativa
(define (sum_iter term a next b)
  (define (iter a result)
    (if (> a b)                       ; Caso base: si a es mayor que b, devolvemos el resultado acumulado.
        result
        (iter (next a)                ; Si no, avanzamos a la siguiente iteración.
              (+ result (term a)))))   ; Acumulamos el resultado de term a en result.
  (iter a 0))

; pruebas
(define (cube x) (* x x x))
(define (inc x) (+ x 2))

(sum cube 2 inc 6)
(sum_iter cube 2 inc 6)

