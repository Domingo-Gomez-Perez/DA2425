#lang racket
(define (make-monitored f)
  (define cont 0)
  (define (mf x)
    (cond ((eq? x 'how-many-calls?) cont) ; Se devuelve el contador con su valor actual
          ((eq? x 'reset-count) (begin (set! cont 0) cont)) ; Se reestablece el contador a 0 y se devuelve
          (else (begin (set! cont (+ cont 1)) (f x))))) ; Si se llama al procedimiento, se ejecuta y se incrementa el contador 
  mf)


(define s (make-monitored sqrt))

; Pruebas
(s 100); -> 10
(s 100); -> 10
(s 'how-many-calls?); -> 2
(s 'reset-count); -> 0
(s 'how-many-calls?); -> 0