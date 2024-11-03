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
        (else (error "unknown expression 
                      type: DERIV" exp))))