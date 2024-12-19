#lang racket
(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))
;El motivo de que no funcione es que se asume qie mcar y mcdr se refieren a pares distintos y que no toma en cuenta listas compartidas.
(define a (mcons 'a (mcons 'b (mcons 'c null)))) ; a |pt -> b | pt -> c null
(count-pairs a) ; Retorna 3

(define b (let ((shared (mcons 'b 'c)))
  (mcons 'a (mcons shared shared)))) ; a -> pt | pt <-> b | c
(count-pairs b) ;Retorna 4

(define c (let ((shared (mcons 'b 'c))) (mcons (mcons 'a shared) (mcons shared (mcons shared null)))) ; a | pt -> pt|pt -> pt | pt <-> b | c
)
(count-pairs c)

(define e (let ((x (mcons 'a null))) (set-mcdr! x x) x))
;(count-pairs e) Entra en bucle infinito al ser una lista circular