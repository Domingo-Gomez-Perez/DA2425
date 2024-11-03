#lang racket

; **Exercise 2.21**: The procedure `square-list`
; takes a list of numbers as argument and returns a list of the squares of those
; numbers.

; ```
; (square-list (list 1 2 3 4))
; (1 4 9 16)
; ```

; Here are two different definitions of `square-list`.  Complete both of
; them by filling in the missing expressions:

; ```
; (define (square-list items)
;   (if (null? items)
;       nil
;       (cons ⟨??⟩ ⟨??⟩)))

; (define (square-list items)
;   (map ⟨??⟩ ⟨??⟩))
; ```


(display "\nExercise 2.21\n")

(define (square x) (* x x))

(define (square-list items)
  (if (null? items)
      null
      (cons (square (car items))  ;; Calcular el cuadrado del primer elemento
            (square-list (cdr items))))) ;; Llamar recursivamente al resto de la lista

;; Otra definición usando `map`
(define (square-list-using-map items)
  (map square items))  ;; Aplicar la función `square` a cada elemento de la lista

;; Ejemplo de uso
(display "square-list: ")
(display (square-list (list 1 2 3 4)))  ;; Debería mostrar (1 4 9 16)
(newline)

(display "square-list-using-map: ")
(display (square-list-using-map (list 1 2 3 4)))  ;; Debería mostrar (1 4 9 16)
(newline)