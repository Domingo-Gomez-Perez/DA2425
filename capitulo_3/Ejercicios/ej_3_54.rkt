#lang racket

(require racket/stream)

; Multiplicación elemento a elemento de dos streams
(define (mul-streams s1 s2)
  (stream-cons (* (stream-first s1) (stream-first s2))
               (mul-streams (stream-rest s1) (stream-rest s2))))

; Genera un stream infinito empezando desde `n`
(define (stream-from n)
  (stream-cons n (stream-from (+ n 1))))


; Stream de enteros: 1, 2, 3, ...
(define integers (stream-from 0))

; Factoriales: producto acumulado de los enteros
(define factorials
  (stream-cons 1 (mul-streams (stream-rest integers) factorials)))

; Función auxiliar: convertir un stream en una lista
(define (stream-to-list s n)
  (if (zero? n)
      '()
      (cons (stream-first s) (stream-to-list (stream-rest s) (- n 1)))))

; Prueba: Obtener los primeros 6 factoriales
(displayln (stream-to-list factorials 6)) ; Salida esperada: (1 1 2 6 24 120)


