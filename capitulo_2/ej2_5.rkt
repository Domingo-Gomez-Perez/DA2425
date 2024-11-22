#lang racket

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

;; Función car para obtener el primer elemento (a)
(define (car a)
  (define (count-divisions5 n divisor)
    (if (zero? (modulo n divisor))
        (+ 1 (count-divisions5 (/ n divisor) divisor))
        0))
  (count-divisions5 a 2))

;; Función cdr para obtener el segundo elemento (b)
(define (cdr a)
  (define (count-divisions5 n divisor)
    (if (zero? (modulo n divisor))
        (+ 1 (count-divisions5 (/ n divisor) divisor))
        0))
  (count-divisions5 a 3))

;; Ejemplo de uso:
(define encoded (cons 2 3))
(display "Valor codificado: ")
(display encoded) ;(2, 3)
(newline)

(display "(a): ")
(display (car encoded)) ; 2
(newline)

(display "(b): ")
(display (cdr encoded)) ;3
(newline)

