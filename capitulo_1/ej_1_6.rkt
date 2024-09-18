#lang racket

;**Exercise 1.6**:

(define (sqrt x) (* x x))


(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) 
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (sqrt guess) x)) 0.001))

(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))


(new-if (= 2 3) 0 5)

(new-if (= 1 1) 0 5)


(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))


;Cuando se intenta ejecutar este código, se desencadena una recursión infinita.
;Esto sucede porque los argumentos de los procedimientos se evalúan antes
;de que el procedimiento sea llamado.
;Es decir, cuando llamas a new-if, ambos, el then-clause y el else-clause,
;son evaluados sin importar el valor de la condición.

;En el caso de sqrt-iter, cuando se evalúa new-if, incluso si la condición "good-enough?"
;es verdadera, la llamada recursiva "(sqrt-iter (improve guess x) x)" en el "else-clause"
;todavía se evalúa. Esto lleva a una recursión infinita.
