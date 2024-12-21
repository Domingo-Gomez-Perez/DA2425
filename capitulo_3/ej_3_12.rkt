#lang racket

(define (append x y)
  (if (null? x)
      y
      (mcons (mcar x) (append (mcdr x) y))))

(define (append! x y)
  (set-mcdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x))))

(define x (mcons 'a (mcons 'b null)))
(define y (mcons 'c (mcons 'd null)))
(define z (append x y))


z ; (mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(mcdr x); esto muestra [b|-> Null], puesto que x no se ha modificado
; x --> [a | o] --> [b | nil]

(define w (append! x y))
; En este caso append! crea una nueva lista pero modificando x ya que modifica
; el ultimo nodo de x (en este caso b) para que apunte al primer nodo de y. X si cambia pero Y no
; Una vez que ha modificado x, la copia en la nueva lista por lo que nos queda:
; x: [a] --> [b] --> [c] --> [d] --> null
; w: [a] --> [b] --> [c] --> [d] --> null 

(mcdr x); esto muestra [b|-> [c|-> [d|-> Null], porque x se ha modificado
; x --> [a | o] --> [b | o] --> [c | o] --> [d | nil]
