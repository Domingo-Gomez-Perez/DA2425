#lang racket
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
;la funcion recibe como parametros a y b
;Primero comprueba si b mayor que 0, en ese caso se usara el signo de suma
;En caso contrario, se usara el signo de resta
;El signo elegido se usara para operar entre a y b