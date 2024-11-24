#lang racket

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons p x) y))
                null sequence)
                
(define (square-list items)
  (if (null? items)
      null
      (cons (square (car items))    ; Cuadrado del primer elemento
            (square-list (cdr items))))) ; Llamada recursiva al resto de la lista

(define (square-list2 items)
  (map square items))  ; Aplica la función square a cada elemento de items

(square-list (list 1 2 3 4)) ; Debería devolver (1 4 9 16)
(square-list2 (list 1 2 3 4)) ; Debería devolver (1 4 9 16)

