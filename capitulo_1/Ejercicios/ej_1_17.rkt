#lang racket
(define (mul a b)
  (if (= b 0)
      0
      (+ a (mul a (- b 1)))))

(define (double x)
  (+ x x))

(define (halve x)
  (/ x 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-mul a b)
  (define (iter a b result)
    (cond
      ((= b 0) result)  ; Caso base: si b es 0, devuelve el resultado acumulado
      ((even? b) (iter (double a) (halve b) result))  ; Si b es par, duplica a y divide b a la mitad
      (else (iter a (- b 1) (+ result a)))))  ; Si b es impar, resta 1 a b y suma a al resultado
  (iter a b 0))  ; La llamada inicial comienza con resultado = 0

(mul 3 7)
(fast-mul 3 7)