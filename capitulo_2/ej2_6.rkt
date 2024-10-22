#lang racket

; **Exercise 2.6:**
; In case representing pairs as
; procedures wasn't mind-boggling enough, consider that, in a language that can
; manipulate procedures, we can get by without numbers (at least insofar as
; nonnegative integers are concerned) by implementing 0 and the operation of
; adding 1 as

; ```
; (define zero (lambda (f) (lambda (x) x)))

; (define (add-1 n)
;   (lambda (f) (lambda (x) (f ((n f) x)))))
; ```

; This representation is known as "Church numerals," after its inventor,
; Alonzo Church, the logician who invented the λ-calculus.

; Define `one` and `two` directly (not in terms of `zero` and
; `add-1`).  (Hint: Use substitution to evaluate `(add-1 zero)`).  Give
; a direct definition of the addition procedure `+` (not in terms of
; repeated application of `add-1`).

;; Numerales de Church
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

;; Suma de numerales de Church
(define church-+ 
  (lambda (m n)
    (lambda (f)
      (lambda (x)
        ((m f) ((n f) x))))))

;; Prueba de numerales Church
(define (church-to-int n)
  ((n (lambda (x) (+ x 1))) 0))

;; Prueba de zero, one, y two sobre el procedimiento de duplicar
(define (dup x) (* 2 x))

;; Pruebas
(display "Dup function with Church numerals:") (newline)
(display "Dup applied 0 times: ") (display ((zero dup) 5)) (newline)  ;; Debería ser 5
(display "Dup applied 1 time: ") (display ((one dup) 5)) (newline)    ;; Debería ser 10
(display "Dup applied 2 times: ") (display ((two dup) 5)) (newline)   ;; Debería ser 20

;; Pruebas de suma de numerales de Church
(display "Church numerals sum test:") (newline)
(display "Sum of zero and one: ") (display (church-to-int (church-+ zero one))) (newline) ;; Debería ser 1
(display "Sum of one and one: ") (display (church-to-int (church-+ one one))) (newline)   ;; Debería ser 2
(display "Sum of one and two: ") (display (church-to-int (church-+ one two))) (newline)   ;; Debería ser 3
