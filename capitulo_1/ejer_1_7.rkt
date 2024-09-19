#lang racket

;La causa de los errores en precisión se debe a la conversión necesaria de base 10 a 2 para almacenar números
;racionales. En los registros, ya sean de memoria o CPU, el formato binario significa que las partes
;decimales no pueden ser expresadas cifra decimal a cifra decimal, sino como el resultado de sumas
;de potencias de dos donde el exponente es negativo.

;Ejemplo:
(- (* 40000000.0006 3) (* 40000000.0007 3))
;La consola muestra "-0.000299990177154541", cuando debería dar
;(40...0.0006 - 40...0.0007) * 3 = -0.0001 * 3 = -0.0003

;Mejora de sqrt-iter:
(define range 0.0000000000001)

(define (abs x) (if (< x 0) (- x) x))

(define (square x) (* x x))


(define (sqrt-iter guess x)
  (define (good-enough? guess x previous-guess)
    (and (< (abs (- guess previous-guess)) (* range guess))))
  (define (average x y) 
    (/ (+ x y) 2))
  (define (improve guess x)
    (average guess (/ x guess)))
  
  (define (sqrt-iter2 guess x previous-guess)
    (if (good-enough? guess x previous-guess)
        guess
        (sqrt-iter2 (improve guess x) x guess)))
  (sqrt-iter2 guess x x)) ;Pongo x por poner un número arbitrario

(sqrt-iter 1.0 2.0)