#lang racket
;funcion que hace repetir otra funcion que toma como parametro n veces
(define (repetir f n)
  (if (= n 1)
      f
      (compose f (repetir f (- n 1)))))

;funcion para hacer el cuadrado de un numero
(define (square x)
  (* x x))
