#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.6: En este ejercicio se implementan números y operaciones básicas usando números de Church.
|#

; Definimos los números de Church:
; El número 0 se define como una función que no hace nada (no aplica la función f).
(define zero (lambda (f) (lambda (x) x)))

; El número 1 aplica la función f una vez.
(define one (lambda (f) (lambda (x) (f x))))

; El número 2 aplica la función f dos veces.
(define two (lambda (f) (lambda (x) (f (f x)))))

; El número 3 aplica la función f tres veces.
(define three (lambda (f) (lambda (x) (f (f (f x))))))

; Función de incremento para probar los números de Church. Suma 1 a un número dado.
(define (inc x)
  (+ x 1))

; Probamos los números de Church aplicando la función 'inc' sobre el número 2.
((two inc) 4) ; Resultado esperado: 6

; Definimos la suma de dos números de Church:
(define (add m n)
  (lambda (f) (lambda (x) ((m f) ((n f) x)))))

; Probamos la suma de dos números de Church (2 + 2) y (3 + 3).
(((add two two) inc) 0) ; Resultado esperado: 4
(((add three three) inc) 0) ; Resultado esperado: 6

; Definimos la operación de exponente de números de Church:
(define (exp m n)
  (lambda (f) (lambda (x) (((m n) f) x))))

; Definimos la multiplicación de números de Church:
(define (mult m n)
  (lambda (f) (lambda (x) ((m (n f)) x))))

; Probamos las operaciones de multiplicación y exponente con los números de Church.
(newline)
(((mult three three) inc) 0) ; Resultado esperado: 9
(((exp three three) inc) 0) ; Resultado esperado: 27

; **Primitivas recursivas**:
; En este ejercicio hemos implementado las operaciones básicas como funciones que utilizan
; exclusivamente los números de Church y las operaciones básicas de funciones.
; Estas operaciones son  *primitivas recursivas*
; cada operación es una función que manipula otras funciones, como el caso de la
; función add que toma dos funciones (m y n), las combina y devuelve una nueva función que
; representa su suma.
; Ahora, implementamos la resta.

; Para definir la resta, necesitamos la operación de predecesor.
(define (pred n)
  (lambda (f) (lambda (x) (((n (lambda (g) (lambda (h) (h (g f))))) (lambda (u) x)) (lambda (u) u)))))

; Definimos la resta en términos de la operación de predecesor.
(define (sub m n)
  ((n pred) m)) ; Usamos el predecesor de 'n' aplicado a 'm'.

; Probamos la resta entre diferentes números de Church:
(newline)
(((sub two one) inc) 0) ; Resultado esperado: 1
(((sub three two) inc) 0) ; Resultado esperado: 1
(((sub three three) inc) 0) ; Resultado esperado: 0
(((sub three one) inc) 0) ; Resultado esperado: 2
(((sub two three) inc)
 0) ; Resultado esperado: 0, ya que la resta está definida como primitiva recursiva
