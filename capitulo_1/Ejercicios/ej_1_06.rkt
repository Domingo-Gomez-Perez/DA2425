#lang racket
(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))


(new-if (= 2 3) 0 5)

(new-if (= 1 1) 0 5)

(define (sqrt guess x)
  (if (good-enough? guess x)
          guess
          (sqrt (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs(- (* guess guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) 
  (/ (+ x y) 2))

(sqrt 1.0 2)

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

(sqrt-iter 1.0 2)

; Como podemos ver entra en un bucle infinito hasta quedarse sin memoria ya que el condicional usa el orden normal en vez del aplicativo que usa el if,
; esto provoca que cada vez que se ejecute el new-if se ejecute siempre en el método sqrt-iter, que hace se ejecute el new-if, que hace que ejecute el sqrt-iter
; y así constantemente esto es porque el tercer argumento del new-if (el del else) es sqrt-iter por lo que se ejecuta infinitamente.