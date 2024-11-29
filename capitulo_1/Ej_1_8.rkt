#lang racket
(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (cube-iter guess x)
  (if (good-enough? guess x)
          guess
          (cube-iter (improve guess x) x)))


(define (cube-iter2 guess x)
  (new-if (good-enough? guess x)
          guess
          (cube-iter2 (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- x (* guess guess guess))) 0.001))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (average x y) 
  (/ (+ x y) 2))

; El problema ocurre debido al orden de la evaluacion de los argumentos. En el caso del if original, el orden de evaluacion es normal ya que solo evalua las
; clausulas necesarias, lo que es obligatorio para el correcto funcionamiento del sqrt-iter.
; Por otra parte, el new-if definido usa un orden aplicatovo por lo tanto, al evaluar todas las clausulas crea un bucle infinito, por lo que podemos concluir
; con que el new-if realmente no funciona igual que el if original.