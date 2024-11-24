#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.5: Show that we can represent pairs of nonnegative integers using only
numbers and arithmetic operations if we represent the pair a and b as the integer
that is the product 2^a * 3^b. Give the corresponding definitions of the procedures
cons, car, and cdr.
|#

; nos dice que creemos el cons como 2^a3^b
(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

; ahora debemos conseguir el car y cdr (teniendo en cuenta que los hemos elevado)
; asi que necesitamos recuperar los numeros segun la base
; usamos este procedimiento para recuperar a y b
; cuenta los factores y cuando llegue a 0 será que ha acabado
(define (factorize n base)
  (if (= (modulo n base) 0)
      (+ 1 (factorize (/ n base) base))
      0))

; ahora el car y cdr los podemos definir asi
(define (car z)
  (factorize z 2))  ; Cuenta los factores de 2

(define (cdr z)
  (factorize z 3))  ; Cuenta los factores de 3

; pruebas
(define punto (cons 2 3)) ; punto representaría (2, 3)
(car punto) ; debería dar 2
(cdr punto) ; debería dar 3