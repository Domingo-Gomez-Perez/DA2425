#lang racket

#|
CAPITULO 1

hecho por Gabriel Gomez Garcia
 |#

#| 1.1The Elements of Programming |#

;  Hay 3 tipos de elementos basicos:
;  expresiones (numeros sin mas o resultados de cosas):
; Todo puede ir en la misma linea si quieres, los parentesis son los que marcan cosas
43
0.4

;  combinaciones (las operaciones):
; siempre va todo entre parentesis y siempre en orden prefix para que sea el resultado igual
(+ 42 37)
(+ 2 3 4 5)
(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))

; SIEMPRE son un operador y dos cosas, si hay parentesis pues cuenta como una cosa todo lo de dentro
; por ejemplo, define no es una combinacion poruqe es un operador pero asocia 1 cosa con otra

;  abstracciones (nombres con define):
(define numero 2)
(+ numero 3)

; se puede definir todo y usar cualquier caracter
(define op +)
(op 2 3)

(define really? 42)
(define <-> 13)
(+ <-> really?)       ; -> 55

#| 1.1.4 Compound Procedures |#

;  definir funciones (procedimientos)
; va asi: (define (⟨name⟩ ⟨formal parameters⟩) ⟨body⟩)

; asi que por ejemplo definimos square con argumento x y lo que tiene que hacer:
(define (square x) (* x x))
(square 4)

; se pueden poner funciones dentro de funciones
(define (sum-of-squares x y)
  (+ (square x) (square y)))

; y funciones dentro de funciones de funciones...
(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

(f 5)

#| 1.1.5The Substitution Model for Procedure Application |#

;  Es como va sustituyendo para calcular esto
; Se va haciendo en paralelo todo lo que se pueda, no es de 1 en 1

; por ejemplo para el f 5:
(f 5)
; primero cambiamos la f por lo que significa
; luego las a por el 5
(sum-of-squares (+ 5 1) (* 5 2))
; ahora hacemos las operaciones y cambiamos por lo que significa
(+ (square 6) (square 10))
; luego cambiamos los square por lo que son
(+ (* 6 6) (* 10 10))
; hacemos las operacioness
(+ 36 100)
; el resultado final
136

; Hay otro timpo de modelo de sustitucion, el orden normal
; Se basa en no evaluar los argumentos hasta que no se necesiten
; en el ejemplo anterior, sería asi (pero no se hace asi en el programa eh):

f(5)
(sum-of-squares (+ 5 1) (* 5 2))

(+ (square (+ 5 1)) (square (* 5 2)))

(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))

; ahora que no se puede hacer nada mas, pues se evaluan los argumentos
(+ (* 6 6) (* 10 10))

(+ 36 100)

136

#| 1.1.6Conditional Expressions and Predicates |#
; Nos falta como hacer if, condiciones o algo porque si no poco vamos a hacer

; En estas solo una de las ramas se evalua por lo que se hacen en orden normal para que vaya mas rapido
; y solo evalue lo justo justo necesario. Tenemos cond y if

; cond
; es como un switch que pueed tener muchos casos
(define (prueba x)
  (cond ((> x 0) 1)
        ((= x 0) 2)
        ((< x 0) 3)))

(define (prueba2 x)
  (cond ((= x 10) 10)
        ((> x 0) 1)
        ((= x 0) 2)
        ((< x 0) 3)
        ((= x 1) 3)
        ((= x 2) 3)))

(prueba 1) ; 1
(prueba 0) ; 2
(prueba -1) ; 3

(prueba2 1) ; 1 va una a una y la primera que se cumpla para y no evalua mas
(prueba2 0) ; 2
(prueba2 -1) ; 3
(prueba2 10) ; 10

;  hemos visto que va una a una, si llega al final sin conseguir ninguna, valor undefined
(define (prueba3 x)
  (cond ((> x 0) 1)))

(prueba3 -10) ; ?? no devuelve na :(

; pero hay una manera para arreglar eso!
(define (prueba4 x)
  (cond ((> x 0) 100)
        (else -100)))

(prueba4 -10) ; ahora si devuelve -100

; otra manera de arreglarlo es con un if que simplifica escribirlo
; El if evalua la expresion y ya despues elije una de las dos posibilidades y solo hace esa
(define (prueba5 x)
  (if (> x 0)
      (100) ; si es true
      -100)) ; si es false

(prueba5 -10) ; igual devuelve -100

; aparte del mayor menor e igual, podemos usar andr, or, not...

; se pueden hasta usar para definir nuevos simbolos!
(define (>= x y)
  (or (> x y) (= x y)))

(>= 3 4)

; o asi
; (define (>= x y)
;   (not (< x y)))

; PRUEBA DE QUE USA LA FORMA NORMAL:

(define (prueba6 x)
  (cond ((> x 0) 1)
        ((= x 0) (/ 0 0))))

(define (prueba7 x)
  (if (> x 0)
      100 ; si es true (no lleva parentesis, solo parentesis si es una expresion)
      (/ 0 0))) ; si es false


(prueba6 10) ; aqui no da error
(prueba6 0) ; da error de division por 0
(prueba7 10) ; aqui no da error
(prueba7 0) ; da error de division por 0

; --- hasta el ejercio 6---

#| 1.1.7 Example: Square Roots by Newton’s Method |#

; es el metodo de newton para aproximar raices, sin mas explica el ejemplo
; dice que los llames procedimientos no funciones que se enfadan si no

; tambien que con lo que hay ahora, podemos escribir cualquier cosa ya, aunque nos
; falta un loop, ahora con esto vemos como se hacen
; (ya visto) en resumen es recursivamente llamando al mismo metodo pero aunque se
; vea recursivo, en verdad en terminos de complejidad, es como si fuera iterativo
; ya que no forma una pila de llamadas nunca, cuando se llama la siguiente vez,
; se destruye el anterior

; por eso ademas se crea un metodo encapsulado, el resultado anterior le vamos pasando
; como un argumento de nuevo uno tras otro mejorandolo

#| 1.1.8 Procedures as Black-Box Abstractions |#

; Lo de newton hemos descompuesto el problema en otros mas pequeños y todo englobado
; en uno mas grande y hemos hechoun define para cada uno y luego lo hemos usado pero,
; queda bastante feo tener 800 defines y que encima todo el codigo pueda acceder a ellos.
; Imagina que tienes dos codigos de sitio distintos, si los copias y tienen algun metodo
; que se llame igual, se fastidia y no compila porque hay dos nombres iguales.
; Asi que la solucion son los local names y definiciones internas:

; Se pueden poner definiciones dentro de definiciones para que solo sean visibles ahi, entre ellas.
; Ademas, si todas usan una x, y esa la tiene la definicion grande, todos la pueden usar y
; se simplifica bastante el codigo. Se llama lexical scooping

; en spacial esta el sqrt con lexical scooping.


#| 1.2 Procedures and the Processes They Generate |#

; ya sabemos lo basico pero ahora, como sabemos que estamos haciendo las cosas bien?
; como sabemos si es eficiente lo que hacemos?
; Vamos a ver maneras de hacer las cosas y sus diferencias y lo que esta bien.

; por ejemplo, para el factorial tenemos dos maneras de haceerlo:

; recursivo:
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

; lo que hace es

(factorial 6)
(* 6 (factorial 5))
(* 6 (* 5 (factorial 4)))
(* 6 (* 5 (* 4 (factorial 3))))
(* 6 (* 5 (* 4 (* 3 (factorial 2)))))
(* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
(* 6 (* 5 (* 4 (* 3 2))))
(* 6 (* 5 (* 4 6)))
(* 6 (* 5 24))
(* 6 120)
720

; como vemos va desde final llegando hasta un caso base haciendo una pila de recursion
;  y cuando llega al base ya empieza a recorrer la pila y calcula cada multiplicaicon.

; iterativo:

(define (factoriali n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

; este hace:

(factorial 6)
(fact-iter 1 1 6)
(fact-iter 1 2 6)
(fact-iter 2 3 6)
(fact-iter 6 4 6)
(fact-iter 24 5 6)
(fact-iter 120 6 6)
(fact-iter 720 7 6)
720

; como vemos, aunque se llame a si mismo, cada vez solo hay uno que va acumulando el reultado
; y ya alfinal cuando llega a n. (va desde el factorial de 1 hasta n) ya para.

; Es un procedimiento recursivo (porque se llama a si mismo) pero sigue un patron lineal, es un proceso iterativo
; es decir, el estado siempre esta entero en cada iteracion


#| 1.2.2Tree Recursion |#

; no entra,
; son cosas de arboles y lo de fibonacci como composicion de n-1 y n-2
; esto es lo de algoritmica de guardar datos de lo que vas haciendo para que sea mas rapido luego

; tambien esta lo del contar el cambio y lo del triangulo de tartaglia

#| 1.2.3Orders of Growth |#

; no entra,
; esto e lo d la complejidad  de los algoritmos, es decir, cuanto tiempo tarda en terminar un algoritmo
; creo que esta bastande claro


#| 1.2.4Exponentiation |#
; nos cuenta que dependiendo como resolvamos pues va a tardar menos o mas
; por ejemplo en las exponentes hay para hacerlo rapido, hay un ejercicio para entenderlo

#| 1.2.5Greatest Common Divisors |#
; Te explica cosas de mcd y como hay un algoritmo para sacarlo

#| 1.2.6Example: Testing for Primality |#
; mucho texto que habla de como encontrar los divisiores de un numero y luego
; los primos y teorema de fermat.

; aqui hasta el ejercicio 17.

#| 1.3Formulating Abstractions with Higher-Order Procedures |#

; Hasta ahora solo hemos estado usando numeros para todo. Pero esto hace que sea un poco
; malo todo esto para crear nuevas cosas.
; Ahora vamos a poder pasar o devolver procedimientos.
; esto se llama high level procedures

#| 1.3.1Procedures as Arguments |#
; Pasar procedimientos como argumentos.
; Si nos fijamos en este codigo:

; Sum the integers a, a+1, a+2, ..., b
(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))

; Sum the cubes, a^3, (a+1)^3, (a+2)^3, ..., b^3
(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (* a a a) (sum-cubes (+ a 1) b))))

; Sum inverse squares, 1/(a^2), 1/((a+1)^2), 1/((a+2)^2), ..., 1/(b^2)
(define (sum-inv-squares a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a a)) (sum-inv-squares (+ a 1) b))))

; Cada uno hace una cosa distinta pero todos estan sumando todo junto.
; Como podemos agrupar esto?

; si nos fijamos podemos ver que en lo unico que difieren es en el teerm
; Sum the integers a, a+1, a+2, ..., b
; (define (sum-integers a b)
;     (if (> a b)
;         0
; 	(+ <term> (sum-integers (+ a 1) b))))

; ; Sum the cubes, a^3, (a+1)^3, (a+2)^3, ..., b^3
; (define (sum-cubes a b)
;     (if (> a b)
;         0
; 	(+ <term> (sum-cubes (+ a 1) b))))

; ; Sum inverse squares, 1/(a^2), 1/((a+1)^2), 1/((a+2)^2), ..., 1/(b^2)
; (define (sum-inv-squares a b)
;     (if (> a b)
;         0
; 	(+ <term> (sum-inv-squares (+ a 1) b))))


; Así, se puede reducir todo eso en:
; Sum terms.   term(a), term(a+1), term(a+2), ... term(b)
(define (sum-terms term a b)
  (if (> a b)
      0
      (+ (term a) (sum-terms (+ a 1) b))))

; y ahora hay que definir cada term segun lo que queramos usar
(define (identity n) n)
(define (cube n) (* n n n))
(define (inv-square n) (/ 1.0 (* n n)))

; Compute some sums
(sum-terms identity 1 5)
(sum-terms cube 1 5)
(sum-terms inv-square 1 5)

; a su vez se pueden encapsular mas los procedimientos para no tener que escribir tanto

; por ejemplo

; (define (sum-cubes a b)
;   (sum cube a inc b))


#| 1.3.2Constructing Procedures Using Lambda |#

; da pereza tener que estar con defines de cada cosa todo el tiempo,
; para eso han inventado lambda, es como un define pero de 1 vez y luego se va.
; sirve bien para definir cosas que solo se usan 1 vez.

(lambda (x) (+ x 4))
(lambda (x) (/ 1.0 (* x (+ x 2))))

; como poner un define pero sin darle nombre.

(define (plus4 x) (+ x 4))
(define plus4.1 (lambda (x) (+ x 4)))

; son lo mismo porque lambda coge lo que le pones y ya


; EL let
;
; es para crear variables locales. Para ir guardando cosas y tal. Lo malo es que
; solo existen las variables dentro del let, fuera no
(define (f1 x y)
  ((lambda (a b)
     (+ (* x (square a))
        (* y b)
        (* a b)))
   (+ 1 (* x y))
   (- 1 y)))

(define (f2 x y)
  (let ((a (+ 1 (* x y)))
        (b (- 1 y)))
    (+ (* x (square a))
       (* y b)
       (* a b))))

; estos dos son lo mismo pero con el let mas claro. Tambien se puede llegar a hacer con defines y tal.
; Pero bueno, otra manera de hacer las cosas. Asi los defines solo se usan para procedimientos y separan
; mejor sus funciones.

#| 1.3.3Procedures as General Methods |#
; Aqui se habla de fixed points, que son lugares de una funcion donde al aplicar un numero
; te devuelve el mismo numero de resultado, nunca cambia y los demas numemros se van acercando
; a ese punto.

; o sea que f(x)=x

; Nos explican cosas de encontrar el punto fijo de distintas funciones.
; (ejemplos probados)

#| 1.3.4Procedures as Returned Values |#
; Se pueden pasar procedimientos como valor de retrorno de las cosas

; por ejemplo, al hacer la derivada de algo, te dan una funcion y tu
; devuelves otra funcion.
; lo de poner @cosas en python tambien indica que es funcion a funcion

