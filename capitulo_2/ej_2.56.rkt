#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.56: Try to expand the deriv procedure to support exponents. Please read the exercise description in the online text (not repeated here due to mathematical typesetting).
|#

; miremos como definir las derivadas primero.
;necesitamos todas estos procedimientos (ninguno esta creado)

; (variable? e)          ;Is e a variable?
; (same-variable? v1 v2) ;Are v1 and v2 the same variable?
; (sum? e)               ;Is e a sum?
; (addend e)             ;Addend of the sum e.
; (augend e)             ;Augend of the sum e.
; (make-sum a1 a2)       ;Construct the sum of a1 and a2.
; (product? e)           ;Is e a product?
; (multiplier e)         ;Multiplier of the product e.
; (multiplicand e)       ;Multiplicand of the product e.
; (make-product m1 m2)   ;Construct the product of m1 and m2.

; definicion de cada cosa

; las variables son simbolos, por ejemplo x
(define (variable? x) (symbol? x))

; seran la misma variable si son el mismo simbolo
(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

; la suma y producto las construimos como listas
; (define (make-sum a1 a2) (list '+ a1 a2))
; (define (make-product m1 m2) (list '* m1 m2))

; si es una suma lo que debemos hacer (primer elemento lista +)
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

; el addend es el segundo elemento de la lista suma '(+ elem1 elem2)
(define (addend s) (cadr s))

; el augend es el tercer elemento de la lista suma '(+ elem1 elem2)
(define (augend s) (caddr s))


; si es un producto lo que debemos hacer (primer elemento lista *)
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

; el multiplier es el segundo elemento de la lista mult '(* elem1 elem2)
(define (multiplier p) (cadr p))

; el multiplicand es el tercer elemento de la lista mult '(* elem1 elem2)
(define (multiplicand p) (caddr p))

; como los resultados salen muy complicados, vamos a reducir para que se vea mejor
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list '+ a1 a2))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0)
             (=number? m2 0))
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2))
         (* m1 m2))
        (else (list '* m1 m2))))


; la derivada final
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

; antes de usarlo, tenemos que saber como representamos una expresion, así
; ax+b será (+ (* a x) b) para que siga todo la misma estructura


;ahora miremos pruebas!

;Derivada de x + 3 con respecto a x
(deriv '(+ x 3) 'x)
; (+ 1 0) -> 1

; Derivada de x * y con respecto a x
(deriv '(* x y) 'x)
; (+ (* x 0) (* 1 y)) -> y

; Derivada de (x * y) * (x + 3) con respecto a x
(deriv '(* (* x y) (+ x 3)) 'x)
; (+ (* (* x y) (+ 1 0)) (* (+ (* x 0) (* 1 y)) (+  x 3)))
; -> (y * (x + 3)) + (x * y)

; como vemos, funciona correctamente.
; ahora hay que expandir la derivada para que acepte exponentes.
; primero debemos saber que significa un exponente para la derivada:

; f(x) = x^n -> f'(x) = n * x^n-1

; sabiendo eso, como en la suma y producto, necesitaremos los mismos  procedimientos
; haré que el simbolo ^ sea lo que marca una exponencial


; si es una potencia lo que debemos hacer (primer elemento lista ^)
(define (power? x)
  (and (pair? x) (eq? (car x) '^)))

; el base es el segundo elemento de la lista power '(^ base exponente)
(define (base p) (cadr p))

; el exponent es el tercer elemento de la lista power '(^ base exponente)
(define (exponent p) (caddr p))

; por ultimo necesitamos una manera de crear la lista final:
; (define (make-power base exponent) (list '^ base exponent))

; tambien lo mejoramos
(define (make-power base exponent)
  (cond ((=number? exponent 0) 1)              ; cualquier cosa ^ 0 es 1
        ((=number? exponent 1) base)           ; cualquier cosa ^ 1 es la cosa misma
        ((and (number? base) (number? exponent))
         (expt base exponent))                 ; evaluar si ambos son números
        (else (list '^ base exponent))))       ; en cualquier otro caso, construir la potencia



; ya tenemos todo lo necesario para crear el caso del exponencial!

; Hasta las potencias todo es exactamente igual, solo hay que anhadir el caso
(define (deriv2 exp var)
  (cond ((number? exp) 0)
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
        ((power? exp) ; Nueva condición para manejar potencias
         (make-product
          (exponent exp)                             ; n
          (make-product                              ; (x ^ (n - 1))
           (make-power (base exp) (- (exponent exp) 1))
           (deriv (base exp) var))))                 ; derivada de la base
        (else (error "unknown expression 
                      type: DERIV" exp))))

; pruebas con potencias
(newline)

; primero veamos que funciona bien el codigo sin potencias
; Derivada de (x * y) * (x + 3) con respecto a x
(deriv2 '(* (* x y) (+ x 3)) 'x)
; (+ (* (* x y) (+ 1 0)) (* (+ (* x 0) (* 1 y)) (+  x 3)))
; -> (y * (x + 3)) + (x * y)

(newline)
(display '(pruebas exponentes))
(newline)

; Derivada de x ^ 3 con respecto a x
(deriv2 '(^ x 3) 'x)
; (* 3 (* (^ x 2) 1))
; -> 3 * (x ^ 2)

; Derivada de (x^2 + 3x) con respecto a x
(deriv2 '(+ (^ x 2) (* 3 x)) 'x)
; (+ (* 2 (* (^ x 1) 1)) (+ (* 3 1) (* 0 x)))
; -> 2x+3


; asi, las derivadas quedan mas bonitas y entendibles a la hora de ejecutarse.
