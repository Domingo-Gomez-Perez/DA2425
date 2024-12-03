#lang racket

; Definicion de fold-right
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op 
                      initial 
                      (cdr sequence)))))

; Definicion de fold-left
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

; Ejemplos del ejercicio: (no deberian dar lo mismo)

(fold-right / 1 (list 1 2 3))
(fold-left  / 1 (list 1 2 3))
(fold-right list null (list 1 2 3))
(fold-left  list null (list 1 2 3))

; La condicion que debe tener op para que los resultados de fold-right y fold-left sean iguales es que sea una asociativa, como la suma o la multiplicaicion
; Es decir, que de lo mismo hacerla de izquierda a derecha que de derecha a izquierda.

; Ejemplos: (deberian dar lo mismo)

(fold-right * 1 (list 1 2 3))
(fold-left  * 1 (list 1 2 3))
(fold-right + 1 (list 1 2 3))
(fold-left  + 1 (list 1 2 3))