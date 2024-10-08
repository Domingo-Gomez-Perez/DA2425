#lang racket
(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5)
(new-if (= 1 1) 0 5)

(define (square x)
  (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (average x y) 
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter2 guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter2 (improve guess x) x)))

(define (sqrt2 x)
  (sqrt-iter2 1.0 x))

(sqrt 2)
(sqrt2 2)

; Cuando Alyssa intenta usar sqrt-iter para calcular raíces cuadradas, el programa no termina.
; ¿Por qué esto causa un problema en el procedimiento sqrt-iter?
;   new-if evalúa tanto la cláusula then (guess) como la cláusula else ((sqrt-iter (improve guess x) x))
;   antes de que se ejecute la función. Incluso si la condición good-enough? es verdadera,
;   la llamada recursiva se evalúa, causando un bucle infinito.
; Comportamiento del if original
;   Si la condición es verdadera, solo se evalúa guess, y la llamada recursiva no se ejecuta,
;   lo que permite que el programa termine correctamente.
