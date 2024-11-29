#lang racket

; Definimos inc para probar mas adelante
(define (inc x)
  (+ x 1))

; Definimos la funcion double que coge una funcion p y crea otra funcion lambda que coge un valor y aplica la funcion p a el valor
(define (double p)
  (lambda (x)
      (p (p x))))

; Ejemplos:

((double inc) 5) ; Nos deberia dar 7

(((double (double double)) inc) 5) ; Nos deberia dar 21 ya que:
; (double double) lo que hace es que la funcion doble se aplique dos veces, es decir de momento tendriamos 2^2 = 4
; Sin embargo cuando aplicamos el double de fuera lo que conseguimos es que se haga 4^2 = 16
; Y una vez tenemos esto hay que hacer el inc 16 veces a 5 lo que dara 21

