#lang racket
;Exercise 2.56: Try to expand the deriv procedure to support exponents.
;Please read the exercise description in the online text (not repeated here due to mathematical typesetting).
;(variable? e)          Is e a variable?
;(same-variable? v1 v2) Are v1 and v2 the same variable?
;(sum? e)               Is e a sum?
;(addend e)             Addend of the sum e.
;(augend e)             Augend of the sum e.
;(make-sum a1 a2)       Construct the sum of a1 and a2.
;(product? e)           Is e a product?
;(multiplier e)         Multiplier of the product e.
;(multiplicand e)       Multiplicand of the product e.
;(make-product m1 m2)   Construct the product of m1 and m2.


;(define (deriv exp var) ;Derivamos la expresion exp respecto a la variable var
;  (cond ((number? exp) 0) ;Si la expresion es un numero, la derivada es 0
;        ((variable? exp) ;Si la expresion es una variable
;         (if (same-variable? exp var) 1 0)) ;Si es la misma variable que de la que se deriva, es d(x) respecto a x = 1, sino 0
;        ((sum? exp)  ;Si la expresion es una suma, dividimos la suma en 
;         (make-sum (deriv (addend exp) var) ;suma de la derivada de la primera parte + derivada de la segunda parte de la suma
;                   (deriv (augend exp) var)))
;        ((product? exp)
;         (make-sum
;          (make-product 
;           (multiplier exp)
;           (deriv (multiplicand exp) var))
;          (make-product 
;           (deriv (multiplier exp) var)
;           (multiplicand exp))))
;        (else (error "unknown expression 
;                      type: DERIV" exp))))

;by adding a new clause to the deriv program and defining appropriate procedures exponentiation?, base, exponent, and make-exponentiation.
;(You may use the symbol ** to denote exponentiation.) Build in the rules that anything raised to the power 0 is 1 and anything raised to the power 1 is the thing itself.

;INCLUYO EXPONENTE

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))
(define (=number? exp num)
  (and (number? exp) (= exp num)))
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) 
         (+ a1 a2))
        (else (list '+ a1 a2))))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) 
             (=number? m2 0)) 
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) 
         (* m1 m2))
        (else (list '* m1 m2))))
(define (addend s) (cadr s))
(define (augend s) (caddr s))
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))

(define (base p) (cadr p))
(define (exponent p) (caddr p))
(define (make-exponentiation m1 m2) 
(cond ((=number? m2 0) 1)
        ((=number? m2 1) m1)
        (else (list '** m1 m2))))

(define (exponentation? p)
  (and (pair? p) (eq? (car p) '**)))

(define (deriv exp var) ;Derivamos la expresion exp respecto a la variable var
  (cond ((number? exp) 0) ;Si la expresion es un numero, la derivada es 0
        ((variable? exp) ;Si la expresion es una variable
         (if (same-variable? exp var) 1 0)) ;Si es la misma variable que de la que se deriva, es d(x) respecto a x = 1, sino 0
        ((sum? exp)  ;Si la expresion es una suma, dividimos la suma en 
         (make-sum (deriv (addend exp) var) ;suma de la derivada de la primera parte + derivada de la segunda parte de la suma
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product 
           (multiplier exp)
           (deriv (multiplicand exp) var))
          (make-product 
           (deriv (multiplier exp) var)
           (multiplicand exp))))
        ((exponentation? exp)
           (make-product (exponent exp) (make-exponentiation (base exp) (- (exponent exp) 1))))
        (else (error "unknown expression 
                      type: DERIV" exp))))

(deriv '(** x 2) 'x)
(deriv '(** x 3) 'x)