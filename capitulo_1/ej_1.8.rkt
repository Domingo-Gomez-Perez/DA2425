#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 1.8: Newton's method for cube roots is based on the fact that if y is
an approximation to the cube root of x, then a better approximation is given by the value:

         x / y^2 + 2y
         -----------
             3

Use this formula to implement a cube-root procedure analogous to the square-root procedure.
In section 1.3.4 we will see how to implement Newton's method in general
as an abstraction of these square-root and cube-root procedures.
|#

; vamos a poner el metodo de la raiz cuadrada y solo hay que cambiar como mejoramos el resultado

; el principal, parece recursivo pero va iterando cada vez aproximando el x
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

; la funcion de newton de mejorar
(define (improve guess x)
  (average guess (/ x guess)))

; la media
(define (average x y)
  (/ (+ x y) 2))

; el sesgo para determinar que hemos acabado, cuando entre los dos valores no cambia mas de 0.001
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.0001))

; el cuadrado
(define (square x) (* x x))

; encapsulamiento para no tener que poner guess nunca y poder poner solo el numero
(define (sqrt x)
  (sqrt-iter 1.0 x))


; debemos cambiar solo esas dos cosas y average ya no hace falta:
(define (cbrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve-cube guess x) x)))

; la funcion de newton de mejorar
(define (improve-cube guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (cbrt x)
  (cbrt-iter 1.0 x))

; Pruebas
(cbrt 8)
(cbrt 9)
(cbrt 64)
(cbrt 256)


