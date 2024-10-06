#lang racket

; **Exercise 2.4:** Here is an alternative procedural
; representation of pairs.  For this representation, verify that `(car (cons x y))`
; yields `x` for any objects `x` and `y`.

; ```
; (define (cons x y) 
;   (lambda (m) (m x y)))

; (define (car z) 
;   (z (lambda (p q) p)))
; ```

; What is the corresponding definition of `cdr`? (Hint: To verify that this
; works, make use of the substitution model of section 1.1.5)

;; Definición de cons, car y cdr usando procedimientos
(define (cons1 x y) 
  (lambda (m) (m x y)))

(define (car1 z) 
  (z (lambda (p q) p)))

(define (cdr1 z)
  (z (lambda (p q) q)))

;; Ejemplo de uso
(define pair (cons1 1 2))
(display "\nLa pareja es: ( 1 , 2 )") 
(newline)
(display (car1 pair)) ;; Debe mostrar 1
(newline)
(display (cdr1 pair)) ;; Debe mostrar 2
(newline)
