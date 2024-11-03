#lang racket


; **Exercise 2.5:** Show that we can represent pairs of
; nonnegative integers using only numbers and arithmetic operations if we
; represent the pair `a` and `b` as the integer that is the product `2^a * 3^b`.
; Give the corresponding definitions of the procedures `cons`,
; `car`, and `cdr`.


;; cons: representa el par (a, b) como 2^a * 3^b
(define (cons5 a b)
  (* (expt 2 a) (expt 3 b)))

;; car: recupera el valor de a (el exponente de 2 en la factorización)
(define (car5 z)
  (define (count-divisions5 n divisor)
    (if (zero? (modulo n divisor))
        (+ 1 (count-divisions5 (/ n divisor) divisor))
        0))
  (count-divisions5 z 2))

;; cdr: recupera el valor de b (el exponente de 3 en la factorización)
(define (cdr5 z)
  (define (count-divisions5 n divisor)
    (if (zero? (modulo n divisor))
        (+ 1 (count-divisions5 (/ n divisor) divisor))
        0))
  (count-divisions5 z 3))

;; Ejemplo de uso
(define pair5 (cons5 2 3))  ;; 2^2 * 3^3 = 108
(cons5 2 3)
pair5
(display (car5 pair5))  ;; Debe mostrar 2
(newline)
(display (cdr5 pair5))  ;; Debe mostrar 3
(newline)