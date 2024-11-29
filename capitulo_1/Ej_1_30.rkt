#lang racket

; Metodo recursivo
(define (sum1 term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum1 term (next a) next b))))

; Metodo iterativo
(define (sum2 term a next b)
  (define (iter a result)
    (if (> a b)           ; Condición de parada: si `a` es mayor que `b`
        result            ; Devolvemos el resultado acumulado
        (iter (next a)    ; Avanzamos al siguiente valor de `a`
              (+ result (term a))))) ; Actualizamos el acumulador sumando `term(a)`
  (iter a 0))             ; Llamada inicial con `a` y resultado acumulado en 0


; Ejemplos:

(sum1 (lambda (x) x) 2 (lambda (x) (+ x 1)) 6) ; Deberia devolver 2+3+4+5+6 = 20
(sum2 (lambda (x) x) 2 (lambda (x) (+ x 1)) 6) ; Deberia devolver 2+3+4+5+6 = 20

(sum1 (lambda (x) x) 1 (lambda (x) (+ x 1)) 5) ; Deberia devolver 1+2+3+4+5 = 15
(sum2 (lambda (x) x) 1 (lambda (x) (+ x 1)) 5) ; Deberia devolver 1+2+3+4+5 = 15