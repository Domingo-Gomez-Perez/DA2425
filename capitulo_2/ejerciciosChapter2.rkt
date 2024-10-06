#lang racket
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2_1\n")
; **Exercise 2.1:** Define a better version of
; `make-rat` that handles both positive and negative arguments.
; `Make-rat` should normalize the sign so that if the rational number is
; positive, both the numerator and denominator are positive, and if the rational
; number is negative, only the numerator is negative.

(define (make-rat-obsoleto n d) (cons n d))
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x))
  (newline))

(define (make-rat num denom)
  (define (gcd a b)
    (if (= b 0)
        (abs a)
        (gcd b (modulo a b))))
  
  (define g (gcd num denom))
  
  (define (normalize n d)
    (cond
      [(and (> n 0) (< d 0)) (values (- n) (abs d))]
      [(and (< n 0) (> d 0)) (values (-(abs n)) (abs d))]
      [else (values (abs n) (abs d))]))
  
  (define-values (num-normalized denom-normalized) (normalize num denom))
  (cons num-normalized denom-normalized))

(display "\nFraccion (3/4) ")
(define r1 (make-rat 3 4))   ; 3/4
(print-rat r1); 
(car r1);3
(cdr r1);4
(display"Fraccion (-3/4) ")
(define r2 (make-rat -3 4))  ; -3/4
(print-rat r2);
(car r2);-3
(cdr r2);4
(display"Fraccion (3/-4) ")
(define r3 (make-rat 3 -4))  ; -3/4
(print-rat r3);
(car r3);-3
(cdr r3);4
(display"Fraccion (-3/-4) ")
(define r4 (make-rat -3 -4)) ; 3/4
(print-rat r4);
(car r4);3
(cdr r4);4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2_2\n")
; **Exercise 2.2:** Consider the problem of
; representing line segments in a plane.  Each segment is represented as a pair
; of points: a starting point and an ending point.  Define a constructor
; `make-segment` and selectors `start-segment` and `end-segment`
; that define the representation of segments in terms of points.  Furthermore, a
; point can be represented as a pair of numbers: the `x` coordinate and the
; `y` coordinate.  Accordingly, specify a constructor `make-point` and
; selectors `x-point` and `y-point` that define this representation.
; Finally, using your selectors and constructors, define a procedure
; `midpoint-segment` that takes a line segment as argument and returns its
; midpoint (the point whose coordinates are the average of the coordinates of the
; endpoints).  To try your procedures, you'll need a way to print points:

; ```
; (define (print-point p)
;   (newline)
;   (display "(")
;   (display (x-point p))
;   (display ",")
;   (display (y-point p))
;   (display ")"))
; ```

;; Constructor para un punto
(define (make-point x y)
  (cons x y))

;; Selectores para obtener las coordenadas x e y de un punto
(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

;; Constructor para un segmento
(define (make-segment start end)
  (cons start end))

;; Selectores para obtener el punto de inicio y el punto final de un segmento
(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

;; Función para calcular el punto medio de un segmento
(define (midpoint-segment s)
  (let ((start (start-segment s))
        (end (end-segment s)))
    (make-point
     (/ (+ (x-point start) (x-point end)) 2)
     (/ (+ (y-point start) (y-point end)) 2))))

;; Función para imprimir un punto
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;; Ejemplo de uso
(define p1 (make-point 1 0))
(define p2 (make-point 3 6))
(define segment (make-segment p1 p2))

(display"\nPunto 1:")
(print-point p1)
(display"\nPunto 2:")
(print-point p2)
(display"\nPunto medio:")
(print-point (midpoint-segment segment))
(newline)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2_4\n")
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2_5\n")
; **Exercise 2.5:** Show that we can represent pairs of
; nonnegative integers using only numbers and arithmetic operations if we
; represent the pair `a` and `b` as the integer that is the product `2^a * 3^b`.
; Give the corresponding definitions of the procedures `cons`,
; `car`, and `cdr`.

;; cons: representa el par (a, b) como 2^a * 3^b
(define (cons5 a b)
  (* (expt 2 a) (expt 3 b)))

;; car: recupera el valor de a (el exponente de 2 en la factorización)
(define (car5 z)
  (define (count-divisions5 n divisor)
    (if (zero? (modulo n divisor))
        (+ 1 (count-divisions5 (/ n divisor) divisor))
        0))
  (count-divisions5 z 2))

;; cdr: recupera el valor de b (el exponente de 3 en la factorización)
(define (cdr5 z)
  (define (count-divisions5 n divisor)
    (if (zero? (modulo n divisor))
        (+ 1 (count-divisions5 (/ n divisor) divisor))
        0))
  (count-divisions5 z 3))

;; Ejemplo de uso
(define pair5 (cons5 2 3))  ;; 2^2 * 3^3 = 108
(display "\nLa pareja es: ( 2 , 3 ); 2*2*3*3*3=108\n")
pair5
(display (car5 pair5))  ;; Debe mostrar 2
(newline)
(display (cdr5 pair5))  ;; Debe mostrar 3
(newline)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2_6\n")
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2_17\n")

; **Exercise 2.17:** Define a procedure
; `last-pair` that returns the list that contains only the last element of a
; given (nonempty) list:

; ```
; (last-pair (list 23 72 149 34))
; (34)
; ```

(define (last-pair lst)
  (if (null? (cdr lst))  ;; Si la cola es vacía, significa que es el último par.
      lst               ;; Devolvemos este par (que contiene el último elemento).
      (last-pair (cdr lst))))  ;; Si no es el último par, seguimos recursivamente.

(last-pair (list 23 72 149 34))
; (34)

(last-pair (list 1 2 3 4 5 6 7 8 9 10 11 12))
;; Resultado: '(12), comprobado

(last-pair (list 4499))
;; Resultado: '(4499)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2_18\n")

; **Exercise 2.18:** Define a procedure `reverse`
; that takes a list as argument and returns a list of the same elements in
; reverse order:

; ```
; (reverse (list 1 4 9 16 25))
; (25 16 9 4 1)
; ```

(define (reverse lst)
  (define (reverse-helper lst acc)
    (if (null? lst)      ;; Si la lista está vacía, devolvemos el acumulador
        acc              ;; que contiene la lista invertida.
        (reverse-helper (cdr lst) (cons (car lst) acc))))  ;; Cons el primer elemento en el acumulador y sigue.
  (reverse-helper lst '()))  ;; Llamada inicial con el acumulador vacío.

(reverse (list 1 4 9 16 25))
; (25 16 9 4 1), comprobado


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2_20\n")

; **Exercise 2.20:** The procedures `+`,
; `*`, and `list` take arbitrary numbers of arguments. One way to
; define such procedures is to use `define` with "dotted-tail notation".  
; In a procedure definition, a parameter list that has a dot before
; the last parameter name indicates that, when the procedure is called, the
; initial parameters (if any) will have as values the initial arguments, as
; usual, but the final parameter's value will be a `list` of any
; remaining arguments.  For instance, given the definition

; ```
; (define (f x y . z) ⟨body⟩)
; ```

; the procedure `f` can be called with two or more arguments.  If we
; evaluate

; ```
; (f 1 2 3 4 5 6)
; ```

; then in the body of `f`, `x` will be 1, `y` will be 2, and
; `z` will be the list `(3 4 5 6)`.  Given the definition

; ```
; (define (g . w) ⟨body⟩)
; ```

; the procedure `g` can be called with zero or more arguments.  If we
; evaluate

; ```
; (g 1 2 3 4 5 6)
; ```

; then in the body of `g`, `w` will be the list `(1 2 3 4 5 6)`.

; Note: Dotted-tail notation is similar to the `*args` syntax in Python.  For example:

; ```
; def f(x, y, *z):
;     ...
; ```

; Use this notation to write a procedure `same-parity` that takes one or
; more integers and returns a list of all the arguments that have the same
; even-odd parity as the first argument.  For example,

; ```
; (same-parity 1 2 3 4 5 6 7)
; (1 3 5 7)

; (same-parity 2 3 4 5 6 7)
; (2 4 6)
; ```

(define (same-parity x . rest)
  (define (same-parity-helper first lst)
    (filter (lambda (n) (= (modulo n 2) (modulo first 2))) lst))
  (cons x (same-parity-helper x rest)))

(same-parity 1 2 3 4 5 6 7)
;; Resultado: '(1 3 5 7)

(same-parity 2 3 4 5 6 7)
;; Resultado: '(2 4 6)

;Comprobado 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise PROXXXXXXXXXXXXXXX\n")



























































































































