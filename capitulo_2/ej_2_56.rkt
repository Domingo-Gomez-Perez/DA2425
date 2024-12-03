#lang racket

; Procedimientos auxiliares

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (make-sum a1 a2) (list '+ a1 a2))
(define (make-product m1 m2) (list '* m1 m2))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

(define (exponentiation? exp)
  (and (pair? exp) 
       (eq? (car exp) 'expt))) 

(define (base exp)
  (cadr exp)) 

(define (exponent exp)
  (caddr exp)) 

(define (make-exponentiation base exponent)
  (list 'expt base exponent)) 



;ORIGINAL
(define (deriv1 exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv1 (addend exp) var)
                   (deriv1 (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product 
           (multiplier exp)
           (deriv1 (multiplicand exp) var))
          (make-product 
           (deriv1 (multiplier exp) var)
           (multiplicand exp))))
        (else (error "unknown expression 
                      type: DERIV" exp))))


(define (deriv2 exp var)
  (cond 
    ((number? exp) 0)
    ((variable? exp)
     (if (same-variable? exp var) 1 0))
    ((sum? exp)
     (make-sum (deriv2 (addend exp) var)
               (deriv2 (augend exp) var)))
    ((product? exp)
     (make-sum
      (make-product 
       (multiplier exp)
       (deriv2 (multiplicand exp) var))
      (make-product 
       (deriv2 (multiplier exp) var)
       (multiplicand exp))))
    ((exponentiation? exp) ; Caso de gestion de exponentes
     (let ((b (base exp))        
           (n (exponent exp)))   
       (if (and (number? n) (same-variable? b var))
           (make-product n      
                         (make-exponentiation b (- n 1)))
           0))) 
    (else (error "unknown expression type: DERIV" exp))))


; Ejemplos:

(deriv2 '(expt x 3) 'x) ; Deveria devolver 3*(x^2)