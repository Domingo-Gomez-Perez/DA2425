#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.21: The procedure square-list takes a list of numbers as argument and 
returns a list of the squares of those numbers.

(square-list (list 1 2 3 4))
; => (1 4 9 16)

Here are two different definitions of square-list. Complete both of them by filling 
in the missing expressions:

(define (square-list items)
  (if (null? items)
      nil
      (cons ⟨??⟩ ⟨??⟩)))

(define (square-list items)
  (map ⟨??⟩ ⟨??⟩))
|#



(define (square-list items)
  (if (null? items)
      '()
      (cons (* (car items) (car items)) (square-list (cdr items)))))



(define (square-list-map items)
  (map (lambda (x) (* x x)) items))



;pruebas:
(square-list (list 1 2 3 4 5))  ; => '(1 4 9 16 25)
(square-list-map (list 1 2 3 4 5)) ; => '(1 4 9 16 25)



