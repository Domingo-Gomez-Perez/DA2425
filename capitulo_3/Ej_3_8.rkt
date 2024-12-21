#lang racket
; Ejercicio 3.8
; La función f no puede terner más de 6-7 líneas

; f

(define c #t)

(define (f x)
        (define (cambia1)
            (set! c #f)
            0
         )
        (define (cambia2)             
             (set! c #t)
             1
         )
        (define oper
             (if c
                 (cambia1)
                 (cambia2))
         )
       oper
)


; Ejecución
(+ (f 0) (f 1))