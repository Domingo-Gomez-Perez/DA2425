#lang racket
(display "\nExercise 2.56\n")
; **Exercise 2.56:**  Try to expand the `deriv` procedure to support exponents.  Please read the
; exercise description in the online text (not repeated here due to mathematical typesetting).

(define (deriv exp var)
  (cond ((number? exp) 0)                       ; La derivada de un número es 0
        ((variable? exp)                        ; Si es una variable
         (if (same-variable? exp var) 1 0))     ; Si es la variable de la derivada, devuelve 1, sino 0
        ((sum? exp) (make-sum (deriv (addend exp) var) (deriv (augend exp) var)))   ; Derivada de una suma
        ((product? exp)                         ; Derivada de un producto
         (make-sum (make-product (multiplier exp) (deriv (multiplicand exp) var))
                    (make-product (deriv (multiplier exp) var) (multiplicand exp))))
        ((exponentiation? exp)                  ; Derivada de una expresión con exponente
         (make-product (exponent exp)
                       (make-exponentiation (base exp) (- (exponent exp) 1))))     ; Evitamos duplicar la base
        (else (error "Expresión desconocida -- DERIV" exp))))

; Helpers para verificar si es un exponente
(define (exponentiation? exp)
  (and (pair? exp) (eq? (car exp) 'expt)))

; Seleccionadores para base y exponente
(define (base exp) (cadr exp))
(define (exponent exp) (caddr exp))

; Constructor para una potencia
(define (make-exponentiation base exponent)
  (cond ((equal? exponent 0) 1)                      ; Si el exponente es 0, devuelve 1
        (else (list 'expt base exponent))))           ; Siempre devuelve la expresión de exponente

; Funciones auxiliares ya conocidas para sumas y productos:
(define (sum? exp) (and (pair? exp) (eq? (car exp) '+)))
(define (addend exp) (cadr exp))
(define (augend exp) (caddr exp))
(define (make-sum a1 a2)
  (cond ((equal? a1 0) a2)
        ((equal? a2 0) a1)
        (else (list '+ a1 a2))))

(define (product? exp) (and (pair? exp) (eq? (car exp) '*)))
(define (multiplier exp) (cadr exp))
(define (multiplicand exp) (caddr exp))
(define (make-product m1 m2)
  (cond ((or (equal? m1 0) (equal? m2 0)) 0)
        ((equal? m1 1) m2)                       ; Si m1 es 1, devuelve m2
        ((equal? m2 1) m1)                       ; Si m2 es 1, devuelve m1
        (else (list '* m1 m2))))                 ; En otros casos, construye el producto

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2) (and (variable? v1) (variable? v2) (eq? v1 v2)))

; Pruebas:
(deriv '(expt x 2) 'x)  ; debería devolver (* 2 (expt x 1))
(deriv '(expt x 3) 'x)  ; debería devolver (* 3 (expt x 2))
