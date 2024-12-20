#lang racket

(define s (stream-cons 1 (add-streams s s)))

; Stream-cons construye un flujo en el que el primer elemento es 1 y el resto va a ser generado por add-streams. Lo que va a hacer en este caso add-streams
; es coger el valor inicial de s que en la primera ejecucion va a ser 1 y va a sumar 1+1=2, al ejecutarlo otra vez va a coger el siguiente valor de s que acaba
; de ser 2 por lo que va a sumar 2+2=4, la tercera ejecucucion va a coger esta vez el 4 y lo va a sumar consigomismo como las iteraciones anteriores 4+4=8,
; este programa va a hacer esto hassta el infinito por lo que s va a quedar de esta manera (1, 2, 4, 8, 16, 32, ...)