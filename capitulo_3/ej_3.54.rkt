#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.54: Define a procedure mul-streams, analogous to add-streams, that produces the elementwise
product of its two input streams. Use this together with the stream of integers to complete the following
definition of the stream whose nth element (counting from 0) is n + 1 factorial:
|#

; va a funcionar igual que add streams pero multiplicando en vez de sumando

; add-streams suma elemento por elemento dos streams:
(define (add-streams s1 s2)
  (stream-map + s1 s2))

; Multiplica elemento a elemento dos streams
(define (mul-streams s1 s2)
  (stream-map * s1 s2))

; Stream de enteros positivos
(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

; Stream de factoriales
(define factorials
  (stream-cons 1 (mul-streams (stream-rest integers) factorials)))

; Obtener los primeros 5 factoriales como prueba
(list (stream-ref factorials 0)
      (stream-ref factorials 1)
      (stream-ref factorials 2)
      (stream-ref factorials 3)
      (stream-ref factorials 4))
; Resultado: '(1 1 2 6 24)