#lang racket
;Ejercicio 3.12

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
;x: [a] --> [b] --> null
(define y (mcons 'c (mcons 'd null)))
;y: [c] --> [d] --> null


(define z (append x y))
;z: [a] --> [b] --> [c] --> [d] --> null
;x: [a] --> [b] --> null
;y: [c] --> [d] --> null

z
;(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(mcdr x)
;Solución:
;Es [b] --> null ya que append no modifica x

(define w (append! x y))
;x:  [a] --> [b] --> [c] --> [d] --> null
;y:  [c] --> [d] --> null
;w:  [a] --> [b] --> [c] --> [d] --> null

w
;(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(mcdr x)
;Solución:
;Es [b] --> [c] --> [d] --> null ya que append! modifica el último par de x 