#lang racket

#|
**Exercise 2.56:**  Try to expand the `deriv` procedure to support exponents.  Please read the
exercise description in the online text (not repeated here due to mathematical typesetting).

Show how to extend the basic differentiator to handle more kinds of expressions. For instance, implement the differentiation rule
d(un)dx=nun-1dudx
by adding a new clause to the deriv program and defining appropriate procedures exponentiation?, base, exponent, and make-exponentiation.
(You may use the symbol ** to denote exponentiation.)
Build in the rules that anything raised to the power 0 is 1 and anything raised to the power 1 is the thing itself.

|#

;The variables are symbols. They are identified by the primitive predicate symbol?:
(define (variable? x) (symbol? x))
;Un símbolo es precedido por '


;Two variables are the same if the symbols representing them are eq?:
(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))


;Sums and products are constructed as lists:
(define (make-sum a1 a2) (list '+ a1 a2))
(define (make-product m1 m2) (list '* m1 m2))


;A sum is a list whose first element is the symbol +:
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
;verifica si x es una lista y si el primer elemento es '+. Al evaluar una lista en racket se evalua como si fuera una lista formada por cons.

;A product is a list whose first element is the symbol *:
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))


;The addend is the second item of the sum list:
(define (addend s) (cadr s))
;cadr retorna el segundo elemento de una lista, es decir, el segundo elemento de una suma " '+ 3 4" (primero termino, ej: 3)


;The augend is the third item of the sum list:
(define (augend s) (caddr s))
;caddr devuelve el tercer elemento de una lista, es decir, el tercer elemento de una suma " '+ 3 4" (segundo termino, ej: 4)




;The multiplier is the second item of the product list:
(define (multiplier p) (cadr p))

;The multiplicand is the third item of the product list:
(define (multiplicand p) (caddr p))


(define (exponentiation? x)
   (and (pair? x) (eq? (car x) '**)))

(define (base e) (cadr e))


(define (exponent e) (caddr e))

(define (make-exponentiation  base exponente)
  (list '** base exponente))


;Función para derivar una expresión con respecto a una variable ( "x", "y",...)
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
        (else (error "unknown expression 
                      type: DERIV" exp))))





(define (deriv-exponentiation exp var)
  ; Usamos `cond` para manejar diferentes tipos de expresiones algebraicas

  (cond 
    ; Caso 1: Si `exp` es un número
    ((number? exp) 0)  ; La derivada de un número es siempre 0

    ; Caso 2: Si `exp` es una variable
    ((variable? exp)
     (if (same-variable? exp var) 1 0)) 
     ; Si la variable de la expresión es igual a la variable `var`, la derivada es 1
     ; Si no es la misma variable, la derivada es 0

    ; Caso 3: Si `exp` es una suma
    ((sum? exp)
     (make-sum 
       (deriv (addend exp) var)   ;; Derivada del primer sumando
       (deriv (augend exp) var))) ;; Derivada del segundo sumando
     ; La derivada de una suma es la suma de las derivadas de sus partes

    ; Caso 4: Si `exp` es un producto
    ((product? exp)
     (make-sum
       (make-product 
         (multiplier exp) 
         (deriv (multiplicand exp) var))  ;; Derivada usando la regla del producto
       (make-product 
         (deriv (multiplier exp) var) 
         (multiplicand exp))))  ;; Derivada usando la regla del producto
     ; La derivada de un producto es la derivada del primer factor multiplicado por el segundo,
     ; más el primer factor multiplicado por la derivada del segundo factor

    ; Caso 5: Si `exp` es una exponenciación
    ((exponentiation? exp)
     (let ((exp-base (base exp))           ; Obtenemos la base de la exponenciación
           (exp-exponente (exponent exp)))  ; Obtenemos el exponente de la exponenciación
       (if (number? exp-exponente)          ; Si el exponente es un número:
           (make-product
            exp-exponente
            (make-exponentiation exp-base (sub1 exp-exponente))  ; Reducimos el exponente
            (deriv exp-base var))           ; Derivada de la base respecto a `var`
           (error "El exponente no es un numero"))))  ; Si el exponente no es un número, lanzamos un error

    ; Caso 6: Si `exp` es un tipo desconocido
    (else (error "unknown expression type: DERIV" exp)))) 
    ; Si `exp` no es de ningún tipo conocido (ni número, ni variable, ni suma, ni producto, ni exponenciación),
    ; lanzamos un error indicando que el tipo de expresión es desconocido.




;Ejemplos
(deriv '(+ x 3) 'x)


(deriv '(* x y) 'x)


(deriv '(* (* x y) (+ x 3)) 'x)
