#lang racket

; **Exercise 2.33:** Fill in the missing expressions
; to complete the following definitions of some basic list-manipulation
; operations as accumulations:

; ```
; (define (map p sequence)
;   (accumulate (lambda (x y) ⟨??⟩) 
;               nil sequence))

; (define (append seq1 seq2)
;   (accumulate cons ⟨??⟩ ⟨??⟩))

; (define (length sequence)
;   (accumulate ⟨??⟩ 0 sequence))
; ```

(define (accumulate combiner null-value sequence)
  (if (null? sequence)                  ; Si la secuencia es vacía
      null-value                        ; Devuelve el valor nulo
      (combiner (car sequence)         ; Aplica el combinador al primer elemento
                 (accumulate combiner null-value (cdr sequence))))) ; Acumula el resto de la secuencia

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) 
              null sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

; Pruebas
(map (lambda (x) (* 2 x)) '(1 2 3 4))     ; Resultado: (2 4 6 8)
(append '(1 2 3) '(4 5 6))                 ; Resultado: (1 2 3 4 5 6)
(length '(1 2 3 4 5))                      ; Resultado: 5
