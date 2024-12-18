#lang racket
(define (simplify expr)
  (cond
    ((number? expr) expr)  ; Si es un número, lo devolvemos tal cual
    ((and (sum? expr) (equal? (augend expr) 0)) (simplify (addend expr))) ; Elimina +0
    ((and (sum? expr) (equal? (addend expr) 0)) (simplify (augend expr))) ; Elimina 0+
    ((sum? expr) (make-sum (simplify (addend expr)) (simplify (augend expr)))) ; Simplifica ambos sumandos
    ((and (product? expr) (equal? (multiplier expr) 1)) (simplify (multiplicand expr))) ; Elimina *1
    ((and (product? expr) (equal? (multiplicand expr) 1)) (simplify (multiplier expr))) ; Elimina 1*
    ((product? expr) (make-product (simplify (multiplier expr)) (simplify (multiplicand expr)))) ; Simplifica ambos factores
    (else expr)))  ; Devuelve la expresión si no es simplificable

;Metodo creado para simplificar y eliminar elementos reduntantes

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (equal? exp var) 1 0))
        ((sum? exp)
         (simplify (make-sum (deriv (addend exp) var)
                             (deriv (augend exp) var))))
        ((product? exp)
         (simplify (make-sum
                    (make-product (multiplier exp)
                                  (deriv (multiplicand exp) var))
                    (make-product (deriv (multiplier exp) var)
                                  (multiplicand exp)))))
        ((exponent? exp)
         (simplify (make-product
                    (make-product (exponent exp)
                                  (make-exponent (base exp) (- (exponent exp) 1)))
                    (deriv (base exp) var))))
        (else (error "unknown expression type: DERIV" exp))))



(define (variable? n)
  (symbol? n))


(define (equal? a b)
  (cond
    ((and (symbol? a) (symbol? b)) (eq? a b))       ;ambos son símbolos
    ((and (number? a) (number? b)) (= a b))          ;ambos son números
    ((and (pair? a) (pair? b))                       ;ambos son listas (pares)
     (and (equal? (car a) (car b))
          (equal? (cdr a) (cdr b))))
    ((and (null? a) (null? b)) #t)                   ;ambos son listas vacías
    (else #f)))                                      ;no son iguales


(define (sum? n)
  (and (pair? n) (equal? (car n) '+)))

(define (make-sum n m)
  (list '+ n m))

(define (addend e)
  (cadr e))

(define (augend e)
  (caddr e))

(define (product? e)
  (and (pair? e) (eq? (car e) '*)))


(define (make-product m1 m2)
  (list '* m1 m2))

(define (multiplier e)
  (cadr e))

(define (multiplicand e)
  (caddr e)) 


(deriv '(+ x 3) 'x)
;Resultado: 1

(deriv '(* x y) 'x)
;Resultado: '(+ (* x 0) y)
;Simplificado: 'y

(deriv '(* (+ x 2) (+ x 3)) 'x)
;Resultado: '(+ (+ x 2) (+ x 3))


(define (exponent? e)
  (and (pair? e) (eq? (car e) '^)))

(define (base e)
  (cadr e))
(define (exponent e)
  (caddr e))

(define (make-exponent base exponent)
  (list '^ base exponent))




(deriv '(^ x 3) 'x)
;Resultado: '(* 3 (^ x 2))

(deriv '(^ (+ x 1) 2) 'x)
;Resultado: '(* 2 (^ (+ x 1) 1))