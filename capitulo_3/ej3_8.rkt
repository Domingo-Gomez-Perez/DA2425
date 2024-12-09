#lang racket

; **Exercise 3.8:** When we defined the evaluation
; model in 1.1.3, we said that the first step in evaluating an
; expression is to evaluate its subexpressions.  But we never specified the order
; in which the subexpressions should be evaluated (e.g., left to right or right
; to left).  When we introduce assignment, the order in which the arguments to a
; procedure are evaluated can make a difference to the result.  Define a simple
; procedure `f` such that evaluating 


; will return 0 if
; the arguments to `+` are evaluated from left to right but will return 1 if
; the arguments are evaluated from right to left.

(define x 0) ; Variable global para rastrear el estado.

(define (f n)
  (if (= x n)
      (begin
        (set! x (+ x 1)) ; Incrementar x.
        0)               ; Retorna 0 si la condición se cumple.
      1))                ; Retorna 1 en cualquier otro caso.

; Reiniciar `x` antes de cada prueba.
(set! x 0)
(display (+ (f 0) (f 1))) ; Primera prueba: evalúa de izquierda a derecha.
(newline)

(set! x 0)
(display (+ (f 1) (f 0))) ; Segunda prueba: evalúa de derecha a izquierda.
(newline)

; Pruebas con cadenas largas de sumas.
(set! x 0)
(display (+ (f 0) (f 1) (f 2) (f 3) (f 4) (f 5) (f 6) (f 7) (f 8) (f 9))) ; Izquierda a derecha.
(newline)

(set! x 0)
(display (+ (f 9) (f 8) (f 7) (f 6) (f 5) (f 4) (f 3) (f 2) (f 1) (f 0))) ; Derecha a izquierda.
(newline)