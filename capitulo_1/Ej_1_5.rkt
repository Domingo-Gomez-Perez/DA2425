#lang racket
(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

; Estos dos procedimientos nos sirven para conocer si el interprete que estamos usando usan orden aplicativo o normal de la siguiente forma:
; El primer procedimiento es un bucle infinito ya que no hay ninguna condicion de parada
; El segundo procedimiento es simplemente una condicion para ver si el primer argumento es 0 y devolver 0 si es verdadero o el segundo argumento si es falso
; Estos dos procedimientos se relacionan con la siguiente expresion: (test 0 (p))
; Con esta expresion, un interprete que usase un orden aplicativo de evaluacion deberia evaluar las dos variables y, tras evaluar (p), entraria en un bucle
; infinito y no terminaria nunca. Por otro lado, si el interprete usase un orden normal de evaluacion, no evaluaria las variables hasta que no son necesarias
; y, ya que para la condicion del if "(p)" no es necesaria, no se evaluaria nunca por lo que no habria bucle infinito y el procedimiento deberia acabar
; mostrando por pantalla "0"