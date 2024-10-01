#lang racket

; **Exercise 1.42:** Let `f` and `g` be two
; one-argument functions.  The composition `f` after `g` is defined
; to be the function that maps `x` to `f(g(x))`.  Define a procedure
; `compose` that implements composition.  For example, if `inc` is a
; procedure that adds 1 to its argument,

; ```
; ((compose square inc) 6)    ; -> 49
; ```

(define (compose f g)
  (lambda (x)
    (f (g x))))

; Definir funciones para probar
(define (inc x)
  (+ x 1))

(define (square x)
  (* x x))

; Ejemplo de uso:
((compose square inc) 6)
; Resultado: 49

; Ejemplo de uso:
((compose inc square) 6)
; Resultado: 37



; COMPROBADO VVVV