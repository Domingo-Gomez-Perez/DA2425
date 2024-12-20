#lang racket

; Definimos una variable global
(define estado #f)

; Definimos f para modificar el estado
(define (f x)
  (if estado
      0; Si el estado esta a true devuelve 0
      (begin
        (set! estado #t) ; Ponemos el estado a true
        (if(= x 0) ; Si la primera llamada tiene x=0 (empieza por la izquierda) devuelvo 0, si no devuelvo 1
           0
           1)))) 

;Ejemplo:

(+ (f 0) (f 1)) ; Deberia devolver 0 ya que + se examina de izquierda a dercha