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

; Lo que hace en este caso el append es crear una nueva lista que combina x e y. Por tanto cuando se ejecuta:
(mcdr x)
; Al no haberse modificado x, el resultado de mcdr x te va a devolver "b" ya que tenemos esta estructura:
#|
  x: [a] --> [b] --> null
  y: [c] --> [d] --> null
  z: [a] --> [b] --> [c] --> [d] --> null (la combinacion de x e y).
|#


(define w (append! x y))
; Sin embargo, lo que hace en este caso append! es crear una nueva lista pero modificando x ya que modifica el ultimo nodo de x (en este caso b) para que
; apunte al primer nodo de y. Una vez que ha modificado x, la copia en la nueva lista por lo que nos queda: 
#|
  x: [a] --> [b] --> [c] --> [d] --> null
  y: [c] --> [d] --> null
  w: [a] --> [b] --> [c] --> [d] --> null (La copia de x)
|#
; Por lo que al ejecutar:
(mcdr x)
; Nos devuelve el segundo elemento de "b" pero como ha sido modificado para apuntar a y nos devuelve "b" "c" y "d"