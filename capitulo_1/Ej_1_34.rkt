#lang racket
; Esta funcion lo que hace es coger otra funcion g y le aplica esa funcion g al numero 2
(define (f g) (g 2))

; Sin embargo si hacemos (f f) nos dara un error ya que el segundo argumento vuelve a ser f que como hamos mencionado antes coge otra funcion y se la aplica
; al numero 2. Sin embargo, ya que los parametros de entrada de f deben ser dos funciones, al entrar una funcion y un numero da error, es decir no puede
; ocurrir (f 2), ya que el 2 no es una funcion a aplicar


(define (square x)
  (* x x))

(f square) ; Aun asi, cuando el segundo parametro de f es una funcion, funciona correctamente.