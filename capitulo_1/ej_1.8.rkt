#lang racket

;Hecho por 
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Exercise 1.8: Newton's method for cube roots is based on the fact that if y is 
an approximation to the cube root of x, then a better approximation is given by the value:

         x / y^2 + 2y
         -----------
             3

Use this formula to implement a cube-root procedure analogous to the square-root procedure.
In section 1.3.4 we will see how to implement Newton's method in general
as an abstraction of these square-root and cube-root procedures.
|#


#|

; manera de conseguir la raiz cuadrada con el metodo de aproximacion
(define (sqrt x)
  (sqrt-iter 1 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- x (* guess guess))) 0.001))

(define (average x y)
  (* 0.5 (+ x y)))

(define (improve guess x)
  (average guess (/ x guess)))

; Pruebas
(sqrt 2)
(sqrt 4)
(sqrt 9)
(sqrt 16)
|#

; Ahora hay que conseguir la cubica
(define (cbrt x)
  (cbrt-iter 1 x))

(define (cbrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (cbrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- x (* guess guess guess))) 0.001))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

;; Pruebas
(cbrt 8)
(cbrt 9)
(cbrt 27)
(cbrt 100)


