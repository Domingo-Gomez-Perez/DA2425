#lang racket
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product 
           (multiplier exp)
           (deriv (multiplicand exp) var))
          (make-product 
           (deriv (multiplier exp) var)
           (multiplicand exp))))
         ((exponentiation? exp)
         (make-product
          (make-product (exponent exp)
                        (make-exponentiation (base exp)
                                             (- (exponent exp) 1)))
          (deriv (base exp) var)))
        (else (error "unknown expression 
                      type: DERIV" exp))))


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



; Exponenciacion
(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

; Seleccionar la base
(define (base e) (cadr e))

; Seleccionar el exponente
(define (exponent e) (caddr e))

; Contructor del exponente
(define (make-exponentiation b e)
  (cond ((= e 0)1)
        ((= e 1)b)
        ((and (number? b) (number? e)) (expt b e))
        (else (list '** b e))))
  
(make-exponentiation 'x 2)
(deriv '(** x 3) 'x)

