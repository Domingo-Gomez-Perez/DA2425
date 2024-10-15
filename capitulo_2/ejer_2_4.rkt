#lang racket

(define (cons x y) 
  (lambda (m) (m x y)))

(define (car z) 
  (z (lambda (p q) p)))
; ((lambda (p q) p) z)) ¿No se supone que la sintaxis exige que el valor metido a lambda esté en la derecha y no la izquierda?
;     Porque no es un parámetro de <<una variable>> (lo cual no tendría sentido), sino que z es una función que evalua lo que
;     te devuelve cons (que si se mete por la derecha)

(define (cdr z)
  (z (lambda (p q) q)))
; ((lambda (p q) p) z)) ¿No se supone que la sintaxis exige que el valor metido a lambda esté en la derecha y no la izquierda?
;     Porque no es un parámetro de <<una variable>> (lo cual no tendría sentido), sino que z es una función que evalua lo que
;     te devuelve cons (que si se mete por la derecha)


(car (cons 1 4))

(cdr (cons 1 4))

((z (lambda (p q) p)))