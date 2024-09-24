#lang racket
; Ejercicio 1.5

(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

(test 0 (p))

; Con un orden aplicativo, el test devolvería '0', porque el primer parámetro 'x' vale '0' y no hace falta más.
; (A menos que el entorno de desarrollo o el compilador se quejen).

; Por otro lado, un orden normal intentará siempre llevar con sigo todos los argumentos de la espresión, por
; lo que al final, cuando le toque sustituir 'p' le saldrá otra vez 'p' y volverá a intentar sustituirla
; en un bucle infinito.