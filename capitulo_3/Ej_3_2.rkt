#lang racket
; Ejercicio 3.2

; make-monitored
; @Param f: procedimiento que toma un solo parámetro
; @Return mf: procedimiento que cuenta las veces que es llamado el procedimiento f. Si mf recive el
; símbolo especial "how-many-calls?", entonces devuelve el número de llamadas de f. Si recive el
; símbolo especial "reset-count", el contador interno vuelve a 0. Si recive cualquier otra cosa,
; devuelve lo mismo que f.

(define (make-monitored f)
    (define cont 0)
    (define (decide x)
        (cond ((equal? x 'how-many-calls?) cont)
              ((equal? x 'reset-count) (set! cont 0))
              (else (set! cont (+ cont 1)) (f x))
      ))
    (lambda (x) (decide x))
  )

; Ejemplos
(define s (make-monitored sqrt))

(s 100)
10

(s 'how-many-calls?)
1