#lang racket
(define (double x) (+ x x))  ; Duplicar un número
(define (halve x) (/ x 2))   ; Reducir a la mitad (se asume que `b` es un entero)

(define (fast-mul a b)
  (define (iter a b result)
    (cond ((= b 0) result)      ; Si `b` es 0, el resultado es el acumulado
          ((even? b)            ; Si `b` es par, duplicamos `a` y reducimos `b` a la mitad
           (iter (double a) (halve b) result))
          (else                 ; Si `b` es impar, añadimos `a` al resultado y restamos 1 a `b`
           (iter a (- b 1) (+ result a)))))
  (iter a b 0))  ; Llamada inicial con el resultado acumulado en 0
