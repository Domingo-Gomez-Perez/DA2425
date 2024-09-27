#lang racket
(define (square x) (* x x))

(define (fast-expt-iter base exp)
  (define (iter base exp resultado)
    (cond ((= exp 0) resultado) ; Cuando exp es 0 devolvemos el resultado
          ((even? exp) (iter (square base) (/ exp 2) resultado)) ; cuando exp es par, hacemos el cuadrado de la base y dividimos el exponente entre 2
          (else (iter base (- exp 1) (* resultado base))))) ;cuando exp es impar, multiplicamos resultado por base y le restamos 1 al exponente 
  (iter base exp 1)) ; empezamos la iteración con resultado 1

(fast-expt-iter 2 3)
; exp impar => (iter base (- exp 1) (* resultado base)) => (iter 2 (- 3 1) (* 1 2)) => (iter 2 2 2) => base 2 exp 2 resultado 2
; exp par => (iter (square base) (/ exp 2) resultado) => (iter (square 2) (/ 2 2) 2) => (iter 4 1 2) => base 4 exp 1 resultado 2
; exp impar => (iter base (- exp 1) (* resultado base)) => (iter 4 (- 1 1) (* 2 4)) => (iter 4 0 8) => base 4 exp 0 resultado 8
; exp = 0 => devolvemos resultado = 8

(fast-expt-iter 2 4)

