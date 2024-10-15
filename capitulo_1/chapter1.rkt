#lang racket
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
10 ; -> 10

(+ 5 3 4) ; -> 12

(- 9 1) ; -> 8

(/ 6 2) ; -> 3

(+ (* 2 4) (- 4 6)) ; -> 6

(define a 3)

(define b (+ a 1))

(+ a b (* a b)) ; -> 19

(= a b) ; -> #f

(if (and (> b a) (< b (* a b)))
    b
    a) ; -> 4
    
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25)) ; -> 16
      
(+ 2 (if (> b a) b a)) ; -> 6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1)) ; -> 16

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (lsqsum x y z)
  (define m (min x y z))
  (cond ((and (not (= x m)) (not (= y m))) (+ (* x x) (* y y)))
        ((and (not (= x m)) (not (= z m))) (+ (* x x) (* z z)))
        ((and (not (= y m)) (not (= z m))) (+ (* y y) (* z z)))))

(lsqsum 2 3 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; El procedimiento a-plus-abs-b hace la siguiente operación:
;    a + |b| -> a + abs(b) -> (+ a abs(b)) ->
;    (if (> b 0) (+ a b) (- a b)) ->
;    (if (> b 0) + -) a b)
;
; En pseudocódigo:
;    a-plus-abs-b(a,b)
;      return a + b if b > 0 else a - b

(a-plus-abs-b 2 4)
(a-plus-abs-b 2 -4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

(test 0 (p))


; 1. Evaluación por orden aplicativo:
; En la evaluación por orden aplicativo, los argumentos de una función se evalúan antes de que la función sea llamada. Al evaluar (test 0 (p)):

; x = 0 se evalúa normalmente.
; y = (p) intenta evaluar la expresión (p), pero como p se define como (define (p) (p)), esto causa una recursión infinita.
; Por lo tanto, con evaluación por orden aplicativo, el intérprete entrará en un bucle infinito al intentar evaluar (p) y nunca terminará.

; 2. Evaluación por orden normal:
; En la evaluación por orden normal, los argumentos de una función no se evalúan hasta que son necesarios. Al evaluar (test 0 (p)):

; x = 0 es evaluado.
; La expresión if (= x 0) es verdadera, por lo que el if retorna 0 sin evaluar y = (p).
; Con evaluación por orden normal, el intérprete retornará 0, ya que nunca necesita evaluar (p), evitando así la recursión infinita.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5)
(new-if (= 1 1) 0 5)

(define (square x)
  (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (average x y) 
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter2 guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter2 (improve guess x) x)))

(define (sqrt2 x)
  (sqrt-iter2 1.0 x))

(sqrt 2)
(sqrt2 2)

; Cuando Alyssa intenta usar sqrt-iter para calcular raíces cuadradas, el programa no termina.
; ¿Por qué esto causa un problema en el procedimiento sqrt-iter?
;   new-if evalúa tanto la cláusula then (guess) como la cláusula else ((sqrt-iter (improve guess x) x))
;   antes de que se ejecute la función. Incluso si la condición good-enough? es verdadera,
;   la llamada recursiva se evalúa, causando un bucle infinito.
; Comportamiento del if original
;   Si la condición es verdadera, solo se evalúa guess, y la llamada recursiva no se ejecuta,
;   lo que permite que el programa termine correctamente.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (crt-iter guess x)
  (if (good-enough? guess x)
      guess
      (crt-iter (improve guess x) x)))

(define (crt x)
  (crt-iter 2.5 x))

(crt 27)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio (inner)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (square x)
  (* x x))

(define (average x y) 
  (/ (+ x y) 2))

; outer procedure
(define (sqrt x)

  ; inner procedures
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

  ; call
  (sqrt-iter 1.0 x))

(sqrt 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (plus a b)
  (if (= a 0) 
      b 
      (inc (plus (dec a) b))))

; (plus 4 5)
; (inc (plus 3 5))
; (inc (inc (plus 2 5)))
; (inc (inc (inc (plus 1 5))))
; (inc (inc (inc (inc (plus 0 5)))))
; (inc (inc (inc (inc 5))))
; (inc (inc (inc 6)))
; (inc (inc 7))
; (inc 8)
; 9
; Es un procedimiento recursivo -> "linear recursion"

(define (plus a b)
  (if (= a 0) 
      b 
      (plus (dec a) (inc b))))

; (plus 4 5)
; (plus 3 6)
; (plus 2 7)
; (plus 1 8)
; (plus 0 9)
; 9
; Es un procedimiento recursivo -> "linear iteration"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.16
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (even? n)
  (= (remainder n 2) 0))

(define (square n)
  (* n n))

(define (halve n)
  (/ n 2))

(define (fast-expt b n) 
  (fast-expt-iter b n 1))

(define (fast-expt-iter b n product)
  (cond ((= n 0)
         product)
        ((even? n) 
         (fast-expt-iter (square b) (halve n) product))
        (else 
         (fast-expt-iter b (- n 1) (* b product)))))

(fast-expt 3 3)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.17
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (even? n)
  (= (remainder n 2) 0))

(define (double n)
  (* n 2))

(define (halve n)
  (/ n 2))

(define (fast-mul a b)
  (cond ((= b 0)
         0)
        ((even? b)
         (fast-mul (double a) (halve b)))
        (else
         (+ a (fast-mul a (- b 1))))))

(fast-mul 5 5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.30
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; original
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

; iterativo
(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(sum (lambda (x) (* x x)) 2 (lambda (x) (+ x 1)) 4)
(sum-iter (lambda (x) (* x x)) 2 (lambda (x) (+ x 1)) 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.31
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; incremento
(define (inc n)
  (+ n 1))

; recursivo
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

; iterativo (2)
(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

; comprobación
(product (lambda (x) (* x x)) 2 (lambda (x) (+ x 1)) 4)
(product-iter (lambda (x) (* x x)) 2 (lambda (x) (+ x 1)) 4)

; factorial
(define (factorial n)
  (product (lambda (x) x) 1 inc n))

(factorial 5)

; aproximación de pi
(define (pi-approx n)
  (define (square x) (* x x))
  (define (next x) (+ x 2))
  (* 4
     (/
      (* 2 (product square 4.0 next n))
      (* n (product square 3.0 next (- n 1))))))

(pi-approx 100)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.32
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; recursivo
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
         (accumulate combiner null-value term (next a) next b))))

; iterativo (2)
(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

; probar suma
(accumulate + 0 (lambda (x) (* x x)) 2 (lambda (x) (+ x 1)) 4)
(accumulate-iter + 0 (lambda (x) (* x x)) 2 (lambda (x) (+ x 1)) 4)

; probar producto
(accumulate * 1 (lambda (x) (* x x)) 2 (lambda (x) (+ x 1)) 4)
(accumulate-iter * 1 (lambda (x) (* x x)) 2 (lambda (x) (+ x 1)) 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicios especiales
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (f x) 
   (let ((a (+ x 10))
         (b (* a 5)))
         (+ a b))
)
(f 2)      ; Fails.  Why?

; Porque se está referenciando la variable `a` dentro de una definición de let antes de que haya sido definida.
; Las variables dentro de un let no pueden referirse entre sí porque las expresiones que les asignan valor se evalúan de manera simultánea,
; no secuencial. En este caso, se está intentando definir `b` usando `a`, pero `a` no está disponible hasta después de que todas las variables del let han sido evaluadas.

(define x 5)
(+ (let ((x 3))
        (+ x (* x 10)))
   x) ; Answer?

; -> 33 (inner) + 5 (outer) -> 38

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.34
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (f g) (g 2))

(define (square x) (* x x))
(f square) ; -> 4
(f (lambda (z) (* z (+ z 1)))) ; -> 6

; (f f) ?
(f f)

; 1. Cuando llamamos a `(f f)`, el procedimiento `f` es pasado como argumento `g` 
;    en la primera instancia de `f`.
;    
;    Por lo tanto, la expresión `(f f)` se convierte en:
;
;    (f 2)
;
; 2. Ahora, `f` espera que `g` sea un procedimiento, pero en este caso, `g` es 
;    el mismo `f`. Esto significa que la expresión se convierte en `(f 2)`.
;    Sin embargo, `f` espera que su argumento sea un procedimiento, no un número.
;    Al intentar aplicar `2` como si fuera una función, esto genera un error.
;
;    "application: not a procedure;
;    expected a procedure that can be applied to arguments
;    given: 2"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.41
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (double f)
  (lambda (x)
    (f (f x))))

(define (inc x)
  (+ x 1))

((double inc) 3) ; -> 5
(((double (double double)) inc) 5) ; -> 21 = 2^4 + 5

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.42
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (square x)
  (* x x))

(define (inc x)
  (+ x 1))

((compose square inc) 6) ; -> 49

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.43
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (repeated (compose f f) (- n 1))))

(define (square x)
  (* x x))

((repeated square 2) 5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1.46
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define tolerance 0.0001)

; iterative-improve
(define (iterative-improve good-enough? improve)
  (define (iter guess x)
      (if (good-enough? guess x)
          guess
          (iter (improve guess x) x)))
  (lambda (guess x) (iter guess x)))

; sqrt en función de iterative-improve
(define (sqrt x)
  (define (good-enough? guess x)
    (define (square x)
      (* x x))
    (< (abs (- (square guess) x)) tolerance))
  (define (improve guess x)
    (define (average x y) 
      (/ (+ x y) 2))
    (average guess (/ x guess)))
  ((iterative-improve good-enough? improve) 1.0 x))

; fixed-point en función de iterative-improve
(define (fixed-point f first-guess)
  (define (good-enough? guess _)
    (< (abs (- guess (f guess))) tolerance))
  (define (improve guess _)
    (f guess))
  ((iterative-improve good-enough? improve) first-guess null))

; comprobar
(sqrt 2)
(fixed-point cos 1.0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio (challenge)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
((lambda (f)
   ((lambda (fact)
      (fact fact 5))
    (lambda (fact n)
      (if (= n 0)
          1
          (* n (fact fact (- n 1)))))))
 (lambda (fact n) (fact fact n)))
