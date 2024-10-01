#lang racket
; **Exercise 1.17:** The exponentiation algorithms in
; this section are based on performing exponentiation by means of repeated
; multiplication.  In a similar way, one can perform integer multiplication by
; means of repeated addition.  The following multiplication procedure (in which
; it is assumed that our language can only add, not multiply) is analogous to the
; `expt` procedure:

; ```
; (define (mul a b)
;   (if (= b 0)
;       0
;       (+ a (mul a (- b 1)))))
; ```

; This algorithm takes a number of steps that is linear in `b`.  Now suppose
; we include, together with addition, operations `double`, which doubles an
; integer, and `halve`, which divides an (even) integer by 2.  Using these,
; design a multiplication procedure analogous to `fast-expt` that uses a
; logarithmic number of steps.

(define (fast-mul a b)
  (cond
    [(= b 0) 0]                  ; Base: si b es 0, el resultado es 0.
    [(even? b) (fast-mul (double a) (halve b))] ; Si b es par, doblamos a y reducimos b a la mitad.
    [else (+ a (fast-mul a (- b 1)))])) ; Si b es impar, reducimos b en 1 y sumamos a.
    
(define (double x) (* 2 x))   ; Definimos la operación de duplicar.
(define (halve x) (/ x 2))    ; Definimos la operación de dividir por 2.

 (define (mul a b)
   (if (= b 0)
       0
       (+ a (mul a (- b 1)))))

(mul 1 2) ; 2
(mul 3 4) ; 12

(fast-mul 1 2) ; 2, comprobado que coincide con mul simple
(fast-mul 3 4) ; 12, comprobado también.

 ;Comprobaciones auxiliares
(double 1);2
(double 3);6
(halve 1);1/2
(halve 3);3/2