#lang racket

(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

(test 0 (p))

; Orden aplicativo: en la evaluacion por orden aplicativo los argumentos
; de la funcion se evaluan al comienzo. Por esto mismo, si el interprete
; utiliza este tipo de evaluacion, cuando se evalua "(test 0 (p))" lo que
; ocurrira es que el interprete entrara en un bucle infinito, ya que "(p)"
; esta definido como si mismo. Es el caso de racket.

; Orden normal: en la evaluacion por orden normal los argumentos no se
; evaluan hasta que realmente se necesitan. Por lo tanto, si el interprete
; utiliza este tipo de evaluacion, cuando se evalua "(test 0 (p))" lo que
; ocurrira es que el interprete devolvera el valor "0", ya que al ser la condicion
; "(= x 0)" verdadera nunca llega a evaluar el argumento "(p)".