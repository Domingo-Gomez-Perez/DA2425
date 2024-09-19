#lang racket

(define (double func)
  (lambda (x) (func (func x))))

(define (inc n) (+ n 1))

((double inc) 3)

(((double (double double)) inc) 5)

;La composición de funciones devuelve un 21.
;Una forma de verlo es mediante sustituciones que multiplican la cantidad de dobles que se hacen de inc:
;
;(((double (double double)) inc)
;      |      |       |
;      |      |       V
;      |      |  (func (func x))
;      |      |       ||
;      |      |    (func2 x)
;      |      |        |
;      |      V        V
;      |    (func2 (func2 x))
;      |           ||
;      |        (func3 x)
;      |            |
;      V            V
;     (func3 (func3 x))
;            ||
;        (func4 x)
;            |
;     Ahora comenzamos a aplicar estos 'doblos' a inc
; (recordar que en la primera sustitución ya se hace un doblo)
;            |
;            |
;            V
;     (inc4 (inc4 x))
;            |
;            V
;     (inc3 (inc3 (inc3 (inc3 x)...)
;            |
;            V

;     (inc2 (inc2 (inc2 (inc2 (inc2 (inc2 (inc2 (inc2 x)...)


;     (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc (inc x)...)
;     
;               Aquí la cantidad de incrementos que se crean son 16,
;                     de ahí que el 5 se transforme en 21.