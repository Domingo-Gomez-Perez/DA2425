#lang racket
(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5)
5
(new-if (= 1 1) 0 5)
0

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

;No funciona el programa ya que new-if evalua a la vex then-clause y else-clause lo que provoca que siempre evalue (sqrt-iter (improve guess x) x)))
;lo que llena la pila. Si se usa el if normal cuando ya es lo suficientemente bueno el resultado solo se evalua (good-enough? guess x) lo que permite al programa terminar.