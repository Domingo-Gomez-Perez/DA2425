#lang racket

; ej1_1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(+ 5 3 4) ; (+ 8 4) ; 12

(- 9 1) ; 8

(/ 6 2) ; 3

(+ (* 2 4) (- 4 6)) ; (+ 8 -2) ; 6

(define a 3) ; Asigna a la variable "a"  el valor entero 3

(define b (+ a 1)) ; (define b (+ 3 1)) ; (define b 4) ; Asigna a b el valor 4

(+ a b (* a b)) ; (+ 3 4 (* 3 4)) ; (+ 3 4 12) ; (+ 7 12) ; 19

(= a b) ; false

(if (and (> b a) (< b (* a b)))
    b
    a)

; (if (and (> 4 3) (< 4 12)))
;   4
;   3)


; (if (and (> 4 3) (< 4 (* 3 4)))
;   4
;   3)

; (if (and true true)))
;   4
;   3)

; 4
    
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

;(cond ((= 3 4) 6)
;      ((= 4 4) (+ 6 7 3))
;      (else 25))

;(cond (false 6)
;      ((= 4 4) (+ 6 7 3))
;      (else 25))

;(true (+ 6 7 3))

;(true (+ 13 3))

;(true 16)

;16
      
(+ 2 (if (> b a) b a))

;(+ 2 (if (> 4 3) 4 3))
;(+ 2 (if true 4 3))
;(+ 2 4)
;6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))

;(* (cond ((> 3 4) 3)
;         ((< 3 4) 4)
;         (else -1))
;   (+ 3 1))

;(* (cond (false 3)
;         ((< 3 4) 4)
;         (else -1))
;   (+ 3 1))

;(* (true 4)
;   (+ 3 1))

;(* 4
;   (+ 3 1))

;(* 4
;   4)

;16

; ej1_2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;5 + 4 + (2 - (3 - (6 + 4/5)))
;-----------------------------
;       3(6 - 2)(2 - 7)

(+ 5 4 ( - 2 ( - 3 (+ 6 (/ 4 5)))))

;-----------------------------

(* 3 (- 6 2) (- 2 7))

; ej1_3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Define a procedure that takes three numbers as
;arguments and returns the sum of the squares of the two larger
;numbers.

(define (sum-of-squares-of-largest a b c)
  (define (square x) (* x x))  ; Define una función para obtener el cuadrado de un número
  (cond
    [(and (<= a b) (<= a c)) (+ (square b) (square c))]  ; Si "a" es el menor, suma los cuadrados de "b" y "c"
    [(and (<= b a) (<= b c)) (+ (square a) (square c))]  ; Si "b" es el menor, suma los cuadrados de "a" y "c"
    [else (+ (square a) (square b))]))  ; Si "c" es el menor, suma los cuadrados de "a" y "b"

(sum-of-squares-of-largest 1 2 3)


; ej1_4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,

; Observe that our model of evaluation allows for
; combinations whose operators are compound expressions.  Use this
; observation to describe the behavior of the following procedure:

; ```
; (define (a-plus-abs-b a b)
;   ((if (> b 0) + -) a b))
; ```

;RESPUESTA: Este procedimiento busca sumar el valor de a con el valor absoluto de b.
; Si b es mayor que 0, entonces se suma a con b. Si b es menor que 0, se le resta b a a. 
; EN este segundo caso se estaría cambiando el signo del valor de b, pasando de negativo
; a positivo, obteniendo en cualquiera de los dos casos "a + abs(b)"

; ej1_5 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,

; Ben Bitdiddle has invented a test to determine whether
; the interpreter he is faced with is using applicative-order evaluation
; or normal-order evaluation.  He defines the following two procedures:

; ```
; (define (p) (p))

; (define (test x y) 
;   (if (= x 0) 
;       0 
;       y))
; ```

; Then he evaluates the expression

; ```
; (test 0 (p))
; ```

; What behavior will Ben observe with an interpreter that uses applicative-order
; evaluation?  What behavior will he observe with an interpreter that uses
; normal-order evaluation?  Explain your answer.  (Assume that the evaluation
; rule for the special form `if` is the same whether the interpreter is
; using normal or applicative order: The predicate expression is evaluated first,
; and the result determines whether to evaluate the consequent or the alternative
; expression.)

;RESPUESTA: Si se usara un orden aplicativo, sucederia que al intentar llamar a la funcion
;llamada "p" se entraría en un bucle infinito, ya que se le asignaria ella misma indefinidamente.
;Si se usara un orden normal, la funcion "test" simplemente devolvería 0, pues en la propia funcion
;"test" se evalua la condicion y se determina que se debe devolver 0 antes de necesitar operar
;con el argumento de entrada "p" (que es el que da problemas en el orden aplicativo.

; ej1_6 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,

; **Exercise 1.6**: Alyssa P. Hacker doesn't see why
; `if` needs to be provided as a special form.  "Why can't I just define it
; as an ordinary procedure in terms of `cond`" she asks.  Alyssa's friend
; Eva Lu Ator claims this can indeed be done, and she defines a new version of `if`:

; ```
; (define (new-if predicate 
;                 then-clause 
;                 else-clause)
;   (cond (predicate then-clause)
;         (else else-clause)))
; ```

; Eva demonstrates the program for Alyssa:

; ```
; (new-if (= 2 3) 0 5)
; 5
; (new-if (= 1 1) 0 5)
; 0
; ```

; Delighted, Alyssa uses `new-if` to rewrite the square-root program:

; ```
; (define (sqrt-iter guess x)
;   (new-if (good-enough? guess x)
;           guess
;           (sqrt-iter (improve guess x) x)))
; ```

; What happens when Alyssa attempts to use this to compute square roots?
; Explain.

(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5)
;5
(new-if (= 1 1) 0 5)
;0

(define (average x y) 
  (/ (+ x y) 2))
  
(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (* guess guess) x)) 0.001))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

;Linea de abajo comentada para correr todos los ejercicios de seguido
;(sqrt-iter 1 2)

;Cuando Alyssa trata de  usar el sqrt-iter, este entra en un bucle infinito. Esto sucede porque
;el nuevo if, teniendo en cuuenta un orden aplicativo (el que es suado), va a evaluar sus argumentos
;entrada constantemente desde el inicio, causando un bucle sin fin.

; ej1_8 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; **Exercise 1.8**: Newton's method for cube roots is
; based on the fact that if `y` is an approximation to the cube root of `x`,
; then a better approximation is given by the value

; ```
; x/y^2 + 2y
; ----------
;     3
; ```

; Use this formula to implement a cube-root procedure analogous to the
; square-root procedure.  In section 1.3.4 we will see how to implement
; Newton's method in general as an abstraction of these square-root and cube-root
; procedures.)

;(define (improve guess x)
;  (/ (+ guess x) 2))

(define (improve2 guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve2 guess x) x)))

(define (cube-root x)
  (cube-root-iter 1.0 x))

;(cube-root 125)


; ej1_9 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; **Exercise 1.9**: Each of the following two procedures defines a
; method for adding two positive integers in terms of the procedures
; `inc`, which increments its argument by 1, and `dec`, which decrements
; its argument by 1.

; ```
; (define (inc x) (+ x 1))
; (define (dec x) (- x 1))

; (define (plus a b)
;   (if (= a 0) 
;       b 
;       (inc (plus (dec a) b))))

; (define (plus a b)
;   (if (= a 0) 
;       b 
;       (plus (dec a) (inc b))))
; ```

; Using the substitution model, illustrate the process generated by each
; procedure in evaluating `(plus 4 5)`.  Are these processes iterative or
; recursive?

(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (plus a b)
  (if (= a 0) 
      b 
      (inc (plus (dec a) b))))

(plus 4 5)
;(if (= 4 0) 5 (inc (plus (dec 4) 5))))
;(inc (plus (dec 4) 5))))
;continuar

(define (plus2 a b)
  (if (= a 0) 
      b 
      (plus (dec a) (inc b))))
; ej1_16 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; **Exercise 1.16:** Design an iterative version of the `fast-expt`
; procedure given in the text.  Hint: to do this, it might help to use a
; subtle trick of algorithm design.  Normally when implementing an
; algorithm, you're thinking about how to break a problem down into
; smaller and smaller steps (e.g., subdividing the problem into parts).  However,
; sometimes it might make sense to change the problem into a different, but
; equivalent problem.  For example, suppose you were computing
; `2^16`. You could rewrite this problem by doubling the base and halving the exponent.
; Thus, it's really the same as computing `4^8`.  Perhaps this trick could be used
; in your solution.

(define (fast-expt-iter a b)
  (define (iter a b result)
    (cond
      [(= b 0) result]  ; Si el exponente llega a 0, devolvemos el resultado.
      [(even? b) (iter (* a a) (/ b 2) result)] ; Si "b" es par, cuadramos "a" y reducimos "b" a la mitad.
      [else (iter a (- b 1) (* result a))])) ; Si es impar, restamos 1 al exp (b) y multiplicamos el result acumulado por "a".
  (iter a b 1)) ; Llamada inicial con el resultado acumulado en 1.

(fast-expt-iter 2 5) ; 32
(fast-expt-iter 2 8) ; 256
(fast-expt-iter 3 7) ; 2187
(fast-expt-iter 4 9) ; 262144

;Comprobado el correcto funcionamiento de fast-exp-iter
; ej1_17 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; **Exercise 1.17:** The exponentiation algorithms in
; this section are based on performing exponentiation by means of repeated
; multiplication.  In a similar way, one can perform integer multiplication by
; means of repeated addition.  The following multiplication procedure (in which
; it is assumed that our language can only add, not multiply) is analogous to the
; `expt` procedure:

; ```
; (define (mul a b)
;   (if (= b 0)
;       0
;       (+ a (mul a (- b 1)))))
; ```

; This algorithm takes a number of steps that is linear in `b`.  Now suppose
; we include, together with addition, operations `double`, which doubles an
; integer, and `halve`, which divides an (even) integer by 2.  Using these,
; design a multiplication procedure analogous to `fast-expt` that uses a
; logarithmic number of steps.

(define (fast-mul a b)
  (cond
    [(= b 0) 0]                  ; Base: si b es 0, el resultado es 0.
    [(even? b) (fast-mul (double a) (halve b))] ; Si b es par, doblamos a y reducimos b a la mitad.
    [else (+ a (fast-mul a (- b 1)))])) ; Si b es impar, reducimos b en 1 y sumamos a.
    
(define (double x) (* 2 x))   ; Definimos la operación de duplicar.
(define (halve x) (/ x 2))    ; Definimos la operación de dividir por 2.

 (define (mul a b)
   (if (= b 0)
       0
       (+ a (mul a (- b 1)))))

(mul 1 2) ; 2
(mul 3 4) ; 12

(fast-mul 1 2) ; 2, comprobado que coincide con mul simple
(fast-mul 3 4) ; 12, comprobado también.

 ;Comprobaciones auxiliares
(double 1);2
(double 3);6
(halve 1);1/2
(halve 3);3/2
; ej1_30 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; **Exercise 1.30:** The following `sum` procedure generates a linear recursion:

(define (sum-terms term a b)
  (if (> a b)
      0
      (+ (term a) (sum-terms term (+ a 1) b))))

(sum-terms (lambda (n) n) 1 5)            ; Suma de enteros
(sum-terms (lambda (n) (* n n n)) 1 5)    ; Suma de cubos
(sum-terms (lambda (n) (/ 1.0 (* n n))) 1 5) ; Suma de inversos de cuadrados


; The procedure can be rewritten so that the sum is performed
; iteratively.  Show how to do this by filling in the missing
; expressions in the following definition:

; ```
; (define (sum term a next b)
;   (define (iter a result)
;     (if ⟨??⟩
;         ⟨??⟩
;         (iter ⟨??⟩ ⟨??⟩)))
;   (iter ⟨??⟩ ⟨??⟩))
; ```

;(sum-terms inv-square 1 5)      ; Suma de inversos de cuadrados de 1 a 5

;Solucion:

(define (next x)
  (+ x 1))

(define (sum-iter term a b)
  (define (iter a result)
    (if (> a b)        ; Condición de parada: si a es mayor que b, retornamos el resultado acumulado.
        result         ; Devolvemos el resultado acumulado.
        (iter (next a) ; Actualizamos a usando la función `next`.
              (+ result (term a))))) ; Sumamos el término actual al resultado acumulado.
  (iter a 0))          ; Iniciamos la iteración con a y un resultado acumulado de 0.

(sum-iter (lambda (n) n) 1 5)            ; Suma de enteros
(sum-iter (lambda (n) (* n n n)) 1 5)    ; Suma de cubos
(sum-iter (lambda (n) (/ 1.0 (* n n))) 1 5) ; Suma de inversos de cuadrados

; Comprobado que coinciden los resultados de sum-terms y sum-iter
; ej1_31 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; **Exercise 1.31:**

; 1. The `sum` procedure is only the simplest of a vast number of similar
; abstractions that can be captured as higher-order procedures. Write an analogous
; procedure called `product` that returns the product of the values of a
; function at points over a given range.  Show how to define `factorial` in
; terms of `product`.  Also use `product` to compute approximations to
; `pi` using the formula

; ```
; pi   2 * 4 * 4 * 6 * 6 * 8 ...
; -- = -------------------------
;  4   3 * 3 * 5 * 5 * 7 * 7 ...
; ```

; 2. If your `product` procedure generates a recursive process, write one that
; generates an iterative process.  If it generates an iterative process, write
; one that generates a recursive process.

; (define (next x)
;   (+ x 1))

; Versión recursiva de product
(define (product term a next b)
  (if (> a b)
      1                             ; Si el rango ha terminado, retornamos 1 (elemento neutro de la multiplicación).
      (* (term a)                   ; Multiplicamos el término actual por el resultado de los términos restantes.
         (product term (next a) next b))))  ; Usamos la función `next` para avanzar.

(define (factorial n)
  (product identity 1 next n))  ; Usa `next` en lugar de una lambda.

(factorial 5)  ; Resultado: 120

(define (pi-product n)
  (* 4
     (/ (product (lambda (x) (* x (+ x 2))) 2 (lambda (x) (+ x 2)) n)  ; Numerador
        (product (lambda (x) (* x x)) 3 (lambda (x) (+ x 2)) n))))     ; Denominador

(pi-product 10000)  ; Aproximación de pi. No funciona !!!!!!!

;Esta es la version iterativa de product:

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))
(define (factorial2 n)
  (product-iter identity 1 next n))

(factorial2 5)  ; Resultado esperado: 120, COnfirmado.

; ej1_32 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; **Exercise 1.32:**

; 1. 

; Show that `sum` and `product` are both special
; cases of a still more general notion called `accumulate` that combines a
; collection of terms, using some general accumulation function:

; ```
; (accumulate combiner null-value term a next b)
; ```

; `Accumulate` takes as arguments the same term and range specifications as
; `sum` and `product`, together with a `combiner` procedure (of
; two arguments) that specifies how the current term is to be combined with the
; accumulation of the preceding terms and a `null-value` that specifies what
; base value to use when the terms run out.  Write `accumulate` and show how
; `sum` and `product` can both be defined as simple calls to `accumulate`.

; 2. If your `accumulate` procedure generates a recursive process, write one
; that generates an iterative process.  If it generates an iterative process,
; write one that generates a recursive process.


(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))


(define (sum1 term a next b)
  (accumulate + 0 term a next b))

(define (product1 term a next b)
  (accumulate * 1 term a next b))


(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))


(define (sum-iter1 term a next b)
  (accumulate-iter + 0 term a next b))

(define (product-iter1 term a next b)
  (accumulate-iter * 1 term a next b))

(sum-iter1 identity 1 add1 5)
; Resultado esperado: 15 (1 + 2 + 3 + 4 + 5)
(sum1 identity 1 add1 5)
; Resultado esperado: 15 (1 + 2 + 3 + 4 + 5)
(product1 identity 1 add1 5)
; Resultado esperado: 120 (1 * 2 * 3 * 4 * 5)
(product-iter1 identity 1 add1 5)
; Resultado esperado: 120 (1 * 2 * 3 * 4 * 5)
(sum1 (lambda (x) (* x x)) 1 add1 3)
; Resultado esperado: 14 (1^2 + 2^2 + 3^2)
(sum-iter1 (lambda (x) (* x x)) 1 add1 3)
; Resultado esperado: 14 (1^2 + 2^2 + 3^2)
(product1 (lambda (x) (* x x)) 1 add1 3)
; Resultado esperado: 36 (1^2 * 2^2 * 3^2)
(product-iter1 (lambda (x) (* x x)) 1 add1 3)
; Resultado esperado: 36 (1^2 * 2^2 * 3^2)
(sum1 identity 2 (lambda (x) (+ x 2)) 10)
; Resultado esperado: 30 (2 + 4 + 6 + 8 + 10)
(sum-iter1 identity 2 (lambda (x) (+ x 2)) 10)
; Resultado esperado: 30 (2 + 4 + 6 + 8 + 10)
(product1 identity 1 (lambda (x) (+ x 2)) 9)
; Resultado esperado: 945 (1 * 3 * 5 * 7 * 9)
(product-iter1 identity 1 (lambda (x) (+ x 2)) 9)
; Resultado esperado: 945 (1 * 3 * 5 * 7 * 9)
(sum1 identity -5 add1 -1)
; Resultado esperado: -15 (-5 + -4 + -3 + -2 + -1)
(sum-iter1 identity -5 add1 -1)
; Resultado esperado: -15 (-5 + -4 + -3 + -2 + -1)
(product1 identity -3 add1 -1)
; Resultado esperado: -6 (-3 * -2 * -1)
(product-iter1 identity -3 add1 -1)
; Resultado esperado: -6 (-3 * -2 * -1)
;(sum1 sqrt 1 add1 4)
; Resultado esperado: 6 (sqrt(1) + sqrt(2) + sqrt(3) + sqrt(4))
;(sum-iter1 sqrt 1 add1 4)
; Resultado esperado: 6 (sqrt(1) + sqrt(2) + sqrt(3) + sqrt(4))
(product1 (lambda (x) (* 2 x)) 1 add1 4)
; Resultado esperado: 384 (2*1 * 2*2 * 2*3 * 2*4)
(product-iter1 (lambda (x) (* 2 x)) 1 add1 4)
; Resultado esperado: 384 (2*1 * 2*2 * 2*3 * 2*4)

; ej1_34 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; **Exercise 1.34:** Suppose we define the procedure

; ```
; (define (f g) (g 2))
; ```

; Then we have

; ```
; (f square)
; 4

; (f (lambda (z) (* z (+ z 1))))
; 6
; ```

; What happens if we (perversely) ask the interpreter to evaluate the combination
; `(f f)`?  Explain.

(define (square x) (* x x))
(define (f g) (g 2))
(f square)
(f (lambda (z) (* z (+ z 1))))

;
;(f f) 

; Error obtenido:

; application: not a procedure;
;  expected a procedure that can be applied to arguments
;   given: 2
;   context...:


; RESPUESTA:
; Este error se debe a que estamos intentando pasar una función que no está diseñada
; para manejar números directamente como su propio argumento, lo que lleva a una 
; confusión en la interpretación del programa y termina en un fallo en tiempo de ejecución.

; ej1_41 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; **Exercise 1.41:** Define a procedure `double`
; that takes a procedure of one argument as argument and returns a procedure that
; applies the original procedure twice.  For example, if `inc` is a
; procedure that adds 1 to its argument, then `(double inc)` should be a
; procedure that adds 2.  What value is returned by

; ```
; (((double (double double)) inc) 5)
; ```

(define (double1 f)
  (lambda (x)
    (f (f x))))

(define (inc1 x)
  (+ x 1))

; (double inc) será una función que incrementa dos veces.
((double1 inc1) 5)
; Resultado: 7 (incrementa 5 dos veces: 5 + 1 + 1 = 7)
((double1 inc1) 8)
; Resultado: 10 (incrementa 5 dos veces: 5 + 1 + 1 = 7)

; ej1_42 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; **Exercise 1.42:** Let `f` and `g` be two
; one-argument functions.  The composition `f` after `g` is defined
; to be the function that maps `x` to `f(g(x))`.  Define a procedure
; `compose` that implements composition.  For example, if `inc` is a
; procedure that adds 1 to its argument,

; ```
; ((compose square inc) 6)    ; -> 49
; ```

(define (compose f g)
  (lambda (x)
    (f (g x))))

; Definir funciones para probar
(define (inc2 x)
  (+ x 1))

(define (square2 x)
  (* x x))

; Ejemplo de uso:
((compose square2 inc2) 6)
; Resultado: 49

; Ejemplo de uso:
((compose inc2 square2) 6)
; Resultado: 37



; COMPROBADO VVVV
; ej1_43 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; **Exercise 1.43:** If `f` is a numerical function
; and `n` is a positive integer, then we can form the nth repeated
; application of `f`, which is defined to be the function whose value at `x`
; is `f(f(...(f(x))))`.  For example, if `f` is the
; function that maps `x` to `x+1`, then the nth repeated application of `f` is
; the function that maps `x` to `x+n`. If `f` is the operation of squaring a
; number, then the nth repeated application of `f` is the function that
; raises its argument to the `2^n` power.  Write a procedure that takes as
; inputs a procedure that computes `f` and a positive integer `n` and returns
; the procedure that computes the nth repeated application of `f`.  Your
; procedure should be able to be used as follows:

; ```
; ((repeated square 2) 5)    ;-> 625
; ```

; Hint: You may find it convenient to use `compose` from Exercise 1.42.


; (define (compose f g)
;   (lambda (x)
;     (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))

; Definir una función para probar
(define (square1 x)
  (* x x))

; Ejemplo de uso:
((repeated square1 2) 5)
; Resultado esperado: 625
((repeated square1 2) 3)
; Resultado esperado: 81

; ej1_46 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; **Exercise 1.46:** Several of the numerical methods
; described in this chapter are instances of an extremely general computational
; strategy known as "iterative improvement".  Iterative improvement says
; that, to compute something, we start with an initial guess for the answer, test
; if the guess is good enough, and otherwise improve the guess and continue the
; process using the improved guess as the new guess.  Write a procedure
; `iterative-improve` that takes two procedures as arguments: a method for
; telling whether a guess is good enough and a method for improving a guess.
; `Iterative-improve` should return as its value a procedure that takes a
; guess as argument and keeps improving the guess until it is good enough.
; Rewrite the `sqrt` procedure of section 1.1.7 and the
; `fixed-point` procedure of section 1.3.3 in terms of
; `iterative-improve`.

(define (iterative-improve good-enough? improve)
  (define (try guess)
    (if (good-enough? guess)
        guess
        (try (improve guess))))
  try)

; Reescribir sqrt usando iterative-improve
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (* guess guess) x)) 0.001))
  (define (improve guess)
    (/ (+ guess (/ x guess)) 2))
  ((iterative-improve good-enough? improve) 1.0))

; Reescribir fixed-point usando iterative-improve
(define (fixed-point f)
  (define (good-enough? guess)
    (< (abs (- (f guess) guess)) 0.001))
  (define (improve guess)
    (f guess))
  ((iterative-improve good-enough? improve) 1.0))

(sqrt 16)           ; Resultado esperado: Aproximadamente 4
(fixed-point cos)    ; Resultado esperado: Aproximadamente 0.739

;COMPROBADO VVVV

















