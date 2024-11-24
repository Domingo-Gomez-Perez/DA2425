#lang racket
; Versión recursiva
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

; Versión iterativa
(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product 
                   counter 
                   max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

; Factorial Recursivo:
; (factorial 6) crea una serie de entornos anidados para cada llamada recursiva.

; Entorno Global:
;   factorial -> [Objeto procedimiento con el código de factorial, apuntando al Global]

; Llamada (factorial 6):
; Crea E1:
;   n: 6
;   Entorno adjunto: Global
;   Cuerpo evaluado:
;      (if (= n 1)
;          1
;          (* n (factorial (- n 1))))

; Llamada (factorial 5) (evaluada dentro de E1):
; Crea E2:
;   n: 5
;   Entorno adjunto: Global
;   Cuerpo evaluado:
;      (if (= n 1)
;          1
;          (* n (factorial (- n 1))))

; Llamada (factorial 4) (evaluada dentro de E2):
; Crea E3:
;   n: 4
;   Entorno adjunto: Global
;   Cuerpo evaluado:
;      (if (= n 1)
;          1
;          (* n (factorial (- n 1))))

; Llamada (factorial 3) (evaluada dentro de E3):
; Crea E4:
;   n: 3
;   Entorno adjunto: Global
;   Cuerpo evaluado:
;      (if (= n 1)
;          1
;          (* n (factorial (- n 1))))

; Llamada (factorial 2) (evaluada dentro de E4):
; Crea E5:
;   n: 2
;   Entorno adjunto: Global
;   Cuerpo evaluado:
;      (if (= n 1)
;          1
;          (* n (factorial (- n 1))))

; Llamada (factorial 1) (evaluada dentro de E5):
; Crea E6:
;   n: 1
;   Entorno adjunto: Global
;   Cuerpo evaluado:
;      (if (= n 1) 1  ... ) -> 1

; Los valores retornados son procesados desde E6 hacia E1, multiplicando el valor de n en cada retorno:
; E6 retorna 1
; E5 calcula (* 2 1) -> 2
; E4 calcula (* 3 2) -> 6
; E3 calcula (* 4 6) -> 24
; E2 calcula (* 5 24) -> 120
; E1 calcula (* 6 120) -> 720

; ------------------------------------------------------------------------

; Factorial Iterativo:
; (factorial 6) crea una única cadena de marcos (frames) que iteran a través del bucle.

; Entorno Global:
;   factorial -> [Objeto procedimiento con el código de factorial, apuntando al Global]
;   fact-iter -> [Objeto procedimiento con el código de fact-iter, apuntando al Global]

; Llamada (factorial 6):
;   Llama a fact-iter con los argumentos:
;      product: 1
;      counter: 1
;      max-count: 6
; Crea E1:
;   product: 1
;   counter: 1
;   max-count: 6
;   Entorno adjunto: Global
;   Cuerpo evaluado:
;      (if (> counter max-count)
;          product
;          (fact-iter (* counter product)
;                     (+ counter 1)
;                     max-count))

; Llamada (fact-iter 1 2 6):
; Crea E2:
;   product: 1
;   counter: 2
;   max-count: 6
;   Entorno adjunto: Global

; Llamada (fact-iter 2 3 6):
; Crea E3:
;   product: 2
;   counter: 3
;   max-count: 6
;   Entorno adjunto: Global

; Llamada (fact-iter 6 4 6):
; Crea E4:
;   product: 6
;   counter: 4
;   max-count: 6
;   Entorno adjunto: Global

; Llamada (fact-iter 24 5 6):
; Crea E5:
;   product: 24
;   counter: 5
;   max-count: 6
;   Entorno adjunto: Global

; Llamada (fact-iter 120 6 6):
; Crea E6:
;   product: 120
;   counter: 6
;   max-count: 6
;   Entorno adjunto: Global

; Llamada (fact-iter 720 7 6):
; Crea E7:
;   product: 720
;   counter: 7
;   max-count: 6
;   Entorno adjunto: Global
;   El cuerpo se evalúa a 720 porque (> counter max-count) es verdadero.

; Los valores retornados son procesados hacia el Entorno Global, con el valor final siendo 720.
