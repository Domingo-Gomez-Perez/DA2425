#lang racket
;funcion que suma 1 al argumento de entrada
(define (masuno x)
  (+ x 1))

;funcion que multiplica por 2 al argumento de entrada
(define (xdos x)
  (* x 2))

;define una funcion tipo f(g(x)) donde g() seria la funcion masuno definida anteriormente y f() seria la funcion xdos definida anteriormente
;dandonos como resultado el argumento de entrada + 1 y luego se multiplica * 2
(define sum-mult (compose xdos masuno))