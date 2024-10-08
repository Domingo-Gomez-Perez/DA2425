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
  (define (same-parity-helper first1 lst20)
    (filter (lambda (n) (= (modulo n 2) (modulo first1 2))) lst20))
  (cons x (same-parity-helper x rest)))

(same-parity 1 2 3 4 5 6 7)
;; Resultado: '(1 3 5 7)

(same-parity 2 3 4 5 6 7)
;; Resultado: '(2 4 6)

;Comprobado 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(display "\nExercise 2_21\n")
; **Exercise 2.21**: The procedure `square-list`
; takes a list of numbers as argument and returns a list of the squares of those
; numbers.

; ```
; (square-list (list 1 2 3 4))
; (1 4 9 16)
; ```

; Here are two different definitions of `square-list`.  Complete both of
; them by filling in the missing expressions:

; ```
; (define (square-list items)
;   (if (null? items)
;       nil
;       (cons ⟨??⟩ ⟨??⟩)))

; (define (square-list items)
;   (map ⟨??⟩ ⟨??⟩))
; ```


(define (square x) (* x x))

(define (square-list items)
  (if (null? items)
      null
      (cons (square (car items))  ;; Calcular el cuadrado del primer elemento
            (square-list (cdr items))))) ;; Llamar recursivamente al resto de la lista

;; Otra definición usando `map`
(define (square-list-using-map items)
  (map square items))  ;; Aplicar la función `square` a cada elemento de la lista

;; Ejemplo de uso
(display "square-list: ")
(display (square-list (list 1 2 3 4)))  ;; Debería mostrar (1 4 9 16)
(newline)

(display "square-list-using-map: ")
(display (square-list-using-map (list 1 2 3 4)))  ;; Debería mostrar (1 4 9 16)
(newline)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(display "\nExercise 2_22\n")
; **Exercise 2.22**: Louis Reasoner tries to rewrite
; the first `square-list` procedure of Exercise 2.21 so that it
; evolves an iterative process:

; ```
; (define (square-list items)
;   (define (iter things answer)
;     (if (null? things)
;         answer
;         (iter (cdr things)
;               (cons (square (car things))
;                     answer))))
;   (iter items nil))
; ```

; Unfortunately, defining `square-list` this way produces the answer list in
; the reverse order of the one desired.  Why?

;RESPUESTA: Se está dando la lista en el orden contrario porque el 
;   proceso de construcción de la lista
;   usa la función cons, que añade los nuevos elementos al inicio de la lista acumulada answer. 
; En cada iteración, el resultado parcial (answer) 
;   tiene los elementos cuadrados, pero los está agregando al frente, 
;    lo que invierte el orden natural de los elementos.


; Louis then tries to fix his bug by interchanging the arguments to `cons`:

; ```
; (define (square-list items)
;   (define (iter things answer)
;     (if (null? things)
;         answer
;         (iter (cdr things)
;               (cons answer
;                     (square 
;                      (car things))))))
;   (iter items nil))
; ```

; This doesn't work either.  Explain.

;RESPUESTA: Este enfoque tampoco funciona correctamente porque ahora la expresión cons 
;   está construyendo pares anidados, no una lista plana. En lugar de agregar el cuadrado 
;   del elemento actual a la lista acumulada, 
;   lo está combinando incorrectamente con answer como el primer argumento de cons.


;Implementación correcta: 

(define (map proc lst)
  (cond
    [(null? lst) '()]  ;; Si la lista está vacía, devolvemos la lista vacía.
    [else (cons (proc (car lst)) (map proc (cdr lst)))]))  ;; Aplicamos la función y continuamos recursivamente.

;Caso de ejemplo:
(display "Aplicar la función cuadrado a (list 1 2 3 4): ")
(display (map (lambda (x) (* x x)) (list 1 2 3 4)))  ;; Debería mostrar (1 4 9 16)
(newline)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; **Exercise 2.23:** The procedure `for-each` is
; similar to `map`.  It takes as arguments a procedure and a list of
; elements.  However, rather than forming a list of the results, `for-each`
; just applies the procedure to each of the elements in turn, from left to right.
; The values returned by applying the procedure to the elements are not used at
; all---`for-each` is used with procedures that perform an action, such as
; printing.  For example,

; ```
; (for-each 
;  (lambda (x) (newline) (display x))
;  (list 57 321 88))

; 57
; 321
; 88
; ```

; The value returned by the call to `for-each` (not illustrated above) can
; be something arbitrary, such as true.  Give an implementation of
; `for-each`.

(define (for-each proc lst)
  (if (null? lst)
      (printf"\n")  ; Retorna algo arbitrario, por ejemplo `#t`
      (begin
        (proc (car lst))  ; Aplica el procedimiento al primer elemento de la lista
        (for-each proc (cdr lst)))))  ; Llama recursivamente para procesar el resto de la lista

(for-each 
 (lambda (x) (newline) (display x))
 (list 57 321 88))

; Salida:
; 57
; 321
; 88

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(display "\nExercise 2_25\n")

; **Exercise 2.25:** Give combinations of `car`s
; and `cdr`s that will pick 7 from each of the following lists:

; ```
; (1 3 (5 7) 9)
; ((7))
; (1 (2 (3 (4 (5 (6 7))))))
; ```

(car (cdr (car (cdr (cdr '(1 3 (5 7) 9))))))
;(car (cdr (car (cdr (3 (5 7) 9)))))
;(car (cdr (car (5 7) 9)))
;(car (cdr (5 7)))
;(car 7)
;7

(car (car '((7))))
;(car (7))
;(7)

(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr '(1 (2 (3 (4 (5 (6 7))))))))))))))))))
;primer cdr: Selecciona el segundo elemento de la entrada (en este caso la entrada es [1, listaX])
;primer car: Selecciona el primer elemento de la listaX
; .
; .
; .
;(car (cdr (car '((6 7)))))
;(car (cdr '(6 7)))
;(car '(7))
;(7)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(display "\nExercise 2_26\n")
; **Exercise 2.26:** Suppose we define `x` and `y` to be two lists:

; ```
; (define x (list 1 2 3))
; (define y (list 4 5 6))
; ```

; What result is printed by the interpreter in response to evaluating each of the
; following expressions:

; ```
; (append x y)
; (cons x y)
; (list x y)
; ```


(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y)
(cons x y)
(list x y)


; (append x y) → (1 2 3 4 5 6)
; (cons x y) → ((1 2 3) 4 5 6)
; (list x y) → ((1 2 3) (4 5 6))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2.27")

; **Exercise 2.27:** Modify your `reverse`
; procedure of Exercise 2.18 to produce a `deep-reverse` procedure
; that takes a list as argument and returns as its value the list with its
; elements reversed and with all sublists deep-reversed as well.  For example,

; ```
; (define x 
;   (list (list 1 2) (list 3 4)))

; x
; ((1 2) (3 4))

; (reverse x)
; ((3 4) (1 2))

; (deep-reverse x)
; ((4 3) (2 1))
; ```

(define (deep-reverse lst)
  (cond
    [(null? lst) '()]  ;; Si la lista está vacía, devolvemos la lista vacía.
    [else (append (deep-reverse (cdr lst)) 
                  (list (if (list? (car lst)) 
                             (deep-reverse (car lst)) 
                             (car lst))))])) ;; Reversamos primero los elementos.

(define x 
  (list (list 1 2) (list 3 4)))

; Imprimir la lista original
x
; Resultado: ((1 2) (3 4))

; Imprimir el resultado de reverse
(reverse x)
; Resultado: ((3 4) (1 2))

; Imprimir el resultado de deep-reverse
(deep-reverse x)
; Resultado: ((4 3) (2 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2.28")

; **Exercise 2.28:** Write a procedure `fringe`
; that takes as argument a tree (represented as a list) and returns a list whose
; elements are all the leaves of the tree arranged in left-to-right order.  For
; example,

; ```
; (define x 
;   (list (list 1 2) (list 3 4)))

; (fringe x)
; (1 2 3 4)

; (fringe (list x x))
; (1 2 3 4 1 2 3 4)
; ```

(define (fringe tree)
  (cond
    [(null? tree) '()]  ; Si el árbol está vacío, devuelve una lista vacía
    [(not (list? (car tree)))  ; Si el primer elemento no es una lista
     (cons (car tree) (fringe (cdr tree)))]  ; Agrega el elemento a la lista de hojas y continúa
    [else  ; Si el primer elemento es una lista
     (append (fringe (car tree)) (fringe (cdr tree)))]))  ; Recurre en el primer elemento y en el resto

; Ejemplos de uso
(define x 
  (list (list 1 2) (list 3 4)))

; Imprimir el resultado de fringe
(fringe x)                   ; Resultado: (1 2 3 4)
(fringe (list x x))         ; Resultado: (1 2 3 4 1 2 3 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2.33")

; **Exercise 2.33:** Fill in the missing expressions
; to complete the following definitions of some basic list-manipulation
; operations as accumulations:

; ```
; (define (map p sequence)
;   (accumulate (lambda (x y) ⟨??⟩) 
;               nil sequence))

; (define (append seq1 seq2)
;   (accumulate cons ⟨??⟩ ⟨??⟩))

; (define (length sequence)
;   (accumulate ⟨??⟩ 0 sequence))
; ```



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2.38")

; **Exercise 2.38:**  The procedure `accumulate` is also known as `fold-right`, because it combines the first element of
; the sequence with the result of combining all the elements to the right.  There
; is also a `fold-left`, which is similar to `fold-right`, except that
; it combines elements working in the opposite direction:

; ```
; (define (fold-left op initial sequence)
;   (define (iter result rest)
;     (if (null? rest)
;         result
;         (iter (op result (car rest))
;               (cdr rest))))
;   (iter initial sequence))
; ```

; What are the values of

; ```
; (fold-right / 1 (list 1 2 3))
; (fold-left  / 1 (list 1 2 3))
; (fold-right list nil (list 1 2 3))
; (fold-left  list nil (list 1 2 3))
; ```

; Give a property that `op` should satisfy to guarantee that
; `fold-right` and `fold-left` will produce the same values for any
; sequence.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2.39")

; **Exercise 2.39:** Complete the following
; definitions of `reverse` (Exercise 2.18) in terms of
; `fold-right` and `fold-left` from Exercise 2.38.

; ```
; (define (reverse sequence)
;   (fold-right 
;    (lambda (x y) ⟨??⟩) nil sequence))

; (define (reverse sequence)
;   (fold-left 
;    (lambda (x y) ⟨??⟩) nil sequence))
; ```




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2.53")

; **Exercise 2.53:** What would the interpreter print
; in response to evaluating each of the following expressions?

; ```
; (list 'a 'b 'c)
; (list (list 'george))
; (cdr '((x1 x2) (y1 y2)))
; (cadr '((x1 x2) (y1 y2)))
; (pair? (car '(a short list)))
; (memq 'red '((red shoes) (blue socks)))
; (memq 'red '(red shoes blue socks))
; ```




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2.54")

; **Exercise 2.54:** Two lists are said to be
; `equal?` if they contain equal elements arranged in the same order.  For
; example,

; ```
; (equal? '(this is a list) 
;         '(this is a list))
; ```

; is true, but

; ```
; (equal? '(this is a list) 
;         '(this (is a) list))
; ```

; is false.  To be more precise, we can define `equal?`  recursively in
; terms of the basic `eq?` equality of symbols by saying that `a` and
; `b` are `equal?` if they are both symbols and the symbols are
; `eq?`, or if they are both lists such that `(car a)` is `equal?`
; to `(car b)` and `(cdr a)` is `equal?` to `(cdr b)`.  Using
; this idea, implement `equal?` as a procedure. (Note: This implementation
; is only concerned with lists of symbols).

; Note: In practice,
; programmers use `equal?` to compare lists that contain numbers as well as
; symbols.  Numbers are not considered to be symbols.  The question of whether
; two numerically equal numbers (as tested by `=`) are also `eq?` is
; highly implementation-dependent.  A better definition of `equal?` (such as
; the one that comes as a primitive in Scheme) would also stipulate that if
; `a` and `b` are both numbers, then `a` and `b` are
; `equal?` if they are numerically equal.  Can you modify `(equal?)` to also
; work with numbers?


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2.55")
; **Exercise 2.55:** Eva Lu Ator types to the
; interpreter the expression

; ```
; (car ''abracadabra)
; ```
; To her surprise, the interpreter prints back `quote`.  Explain.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display"\nExercise 2.56")
; **Exercise 2.56:**  Try to expand the `deriv` procedure to support exponents.  Please read the
; exercise description in the online text (not repeated here due to mathematical typesetting).
























































































































