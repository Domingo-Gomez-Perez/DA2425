#lang racket
; Ejercicio 3.12

(define (append x y)
  (if (null? x)
      y
      (mcons (mcar x) (append (mcdr x) y))))

(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x))))

(define (append! x y)
  (set-mcdr! (last-pair x) y)
  x)

(define x (mcons 'a (mcons 'b null)))
(define y (mcons 'c (mcons 'd null)))
(define z (append x y))

z
(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(mcdr x)
; Response:
; Asumiendo que la pregunta es (mcdr x), devolvería (mcons 'b null). Esto se debe a que la función
; append no modifica ningún puntero, simplemente recorre 'x' e 'y' y devuelve una lista con los
; elementos de 'x' al principio y los elementos de 'y' al final.

(define w (append! x y))

w
(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(mcdr x)
; Response:
; Asumiendo que la pregunta es (mcdr x), devolvería (mcons 'b (mcons 'c (mcons 'd '()))). Esto se debe
; a que append! sí modifica punteros, para ser más específicos, manipula el puntero del último elemento
; (cdr) de 'x', haciendo que coincida con el valor al que apunta 'y'.