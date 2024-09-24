#lang racket
; **Exercise 1.30:** The following `sum` procedure generates a linear recursion:

; ```
; (define (sum term a next b)
;   (if (> a b)
;       0
;       (+ (term a)
;          (sum term (next a) next b))))
; ```

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
(define (sum-terms term a b)
  (if (> a b)
      0
      (+ (term a) (sum-terms term (+ a 1) b))))

(sum-terms identity 1 5)
; Output: 15
;(sum-terms inv-square 1 5)      ; Suma de inversos de cuadrados de 1 a 5


(sum-terms (lambda (n) n) 1 5)            ; Suma de enteros
(sum-terms (lambda (n) (* n n n)) 1 5)    ; Suma de cubos
(sum-terms (lambda (n) (/ 1.0 (* n n))) 1 5) ; Suma de inversos de cuadrados
