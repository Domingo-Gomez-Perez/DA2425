#lang racket




; **Exercise 1.30:** The following `sum` procedure generates a linear recursion:

(define (sum-terms term a b)
  (if (> a b)
      0
      (+ (term a) (sum-terms term (+ a 1) b))))

(sum-terms (lambda (n) n) 1 5)            ; Suma de enteros
(sum-terms (lambda (n) (* n n n)) 1 5)    ; Suma de cubos
(sum-terms (lambda (n) (/ 1.0 (* n n))) 1 5) ; Suma de inversos de cuadrados


; The procedure can be rewritten so that the sum is performed
; iteratively.  Show how to do this by filling in the missing
; expressions in the following definition:

; ```
; (define (sum term a next b)
;   (define (iter a result)
;     (if ⟨??⟩
;         ⟨??⟩
;         (iter ⟨??⟩ ⟨??⟩)))
;   (iter ⟨??⟩ ⟨??⟩))
; ```

;(sum-terms inv-square 1 5)      ; Suma de inversos de cuadrados de 1 a 5

;Solucion:

(define (next x)
  (+ x 1))

(define (sum-iter term a b)
  (define (iter a result)
    (if (> a b)        ; Condición de parada: si a es mayor que b, retornamos el resultado acumulado.
        result         ; Devolvemos el resultado acumulado.
        (iter (next a) ; Actualizamos a usando la función `next`.
              (+ result (term a))))) ; Sumamos el término actual al resultado acumulado.
  (iter a 0))          ; Iniciamos la iteración con a y un resultado acumulado de 0.

(sum-iter (lambda (n) n) 1 5)            ; Suma de enteros
(sum-iter (lambda (n) (* n n n)) 1 5)    ; Suma de cubos
(sum-iter (lambda (n) (/ 1.0 (* n n))) 1 5) ; Suma de inversos de cuadrados

; Comprobado que coinciden los resultados de sum-terms y sum-iter