#lang racket
#|

Hacer el ej 2.6 para mult y suma
|#



(define zero (lambda (f) (lambda (x) x)))


(define one
  (lambda (f) (lambda (x) (f x))))

(define two
  (lambda (f) (lambda (x) (f(f x)))))

(define three
  (lambda (f) (lambda (x) (f(f(f x))))))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define (incremento x)
  (+ x 1))


(((add-1 (add-1 one))incremento)0)

(((add-1 one)incremento)0)


(define (power n m)

  (lambda (f) (lambda (x) ((m n) f) x)))


  

(define (suma-func n m)

  (lambda (f) (lambda (x) ((n f) ((m f) x))))
  )

(define (multiplicacion n m)
  (lambda (f) (lambda (x) ((n (m f)) x))))


;2 * 2 = sumar 2 2 veces

;1 * 2 = sumar 1 2 veces

(((suma-func one two)incremento) 0) ;lo que hago es incrementar 0 (x) 2 veces (m) y al resultado de eso le aplico la función incremento 1 vez (n), sería como hacer
                                     ;una composición de funciones
(((power one two)incremento) 0) 

(((multiplicacion three two)incremento) 0)