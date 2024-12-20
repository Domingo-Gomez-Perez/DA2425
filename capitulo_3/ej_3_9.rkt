#lang racket


#|
**Exercise 3.9:** Will discuss as a group.  In 1.2.1 we used the
substitution model to analyze two procedures for computing factorials, a
recursive version

```
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
```

and an iterative version

```
(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product 
                   counter 
                   max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))
```

Show the environment structures created by evaluating `(factorial 6)`
using each version of the `factorial` procedure.

|#


;Versión recursiva


(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))


#|
Respuesta para (factorial 6):

Global
 |_ factorial
     |_ E1: n=6 → (* 6 (factorial 5))
     |_ E2: n=5 → (* 5 (factorial 4))
     |_ E3: n=4 → (* 4 (factorial 3))
     |_ E4: n=3 → (* 3 (factorial 2))
     |_ E5: n=2 → (* 2 (factorial 1))
     |_ E6: n=1 → 


En la versión recursiva, el ambiente (E) global contiene la definición del procedimiento factorial. Este procedimiento está disponiblera ser llamado desde cualquier parte del programa.
Cada vez que se invoca (factorial n), el procedimiento se ejecuta en un nuevo ambiente local, pero siempre usando la definición original que reside en el ambiente global.
Cuando evaluamos (factorial 6): En el ambiente global, tenemos almacenada la función factorial. Aquí se inicia la evaluación de (factorial 6). Al entrar en la primera llamada,
se crea un nuevo ambiente local (digamos E1), que guarda el valor de n = 6. Este ambiente es independiente del global, pero puede acceder a él para usar el procedimiento factorial.
A medida que se realizan más llamadas recursivas, se crean nuevos ambientes locales (E2, E3, etc.), uno para cada llamada, cada uno con su propio valor de n.
Estos ambientes también acceden al global para invocar a factorial nuevamente. Cada ambiente local utiliza la definición global, pero almacena sus propios valores de n y su propio cálculo parcial.

 -Cuando se llama a (factorial 6): Se crea un ambiente donde n = 6. Como n ≠ 1, se evalúa (* 6 (factorial 5)) ----> 720.
 -Cuando se llama a (factorial 5): Se crea un nuevo ambiente donde n = 5. Como n ≠ 1, se evalúa (* 5 (factorial 4))----> 120.
 -Cuando se llama a (factorial 4): Se crea un nuevo ambiente donde n = 4. Se evalúa (* 4 (factorial 3))----> 24.
 -Cuando se llama a (factorial 3): Se crea un ambiente donde n = 3. Se evalúa (* 3 (factorial 2))----> 6.
 -Cuando se llama a (factorial 2): Se crea un ambiente donde n = 2. Se evalúa (* 2 (factorial 1))----> 2.
 -Cuando se llama a (factorial 1): Se crea un ambiente donde n = 1. Como n = 1, se devuelve 1.

Finalmente, las llamadas pendientes se resuelven hacia atrás: (* 2 1) --> 2 (* 3 2) --> 6 (* 4 6) --> 24 (* 5 24) --> 120 (* 6 120) --> 720.

El resultado es 720.

|#


;Versión iterativa

(define (factorial2 n)
  (fact-iter 1 1 n))

(define (fact-iter product 
                   counter 
                   max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))



#|
Respuesta para (factorial2 6):


Global
 |_ factorial
     |_ fact-iter: product=720, counter=7, max-count=6


En la versión iterativa, también hay una definición global para el procedimiento factorial, pero esta invoca a un procedimiento auxiliar llamado fact-iter.
Ambos (factorial y fact-iter) están definidos en el ambiente global y accesibles desde cualquier parte del programa. Sin embargo, a diferencia de la versión recursiva,
la iterativa no crea múltiples ambientes locales. Cuando evaluamos (factorial 6): En el ambiente global, tenemos almacenadas las definiciones de factorial y fact-iter.
La evaluación comienza con la llamada a (factorial 6). factorial invoca a fact-iter con los valores iniciales: product = 1, counter = 1, y max-count = 6.

Fact-iter realiza las iteraciones dentro del mismo ambiente. Aquí, las variables product, counter, y max-count se actualizan en cada iteración,
pero no se crean nuevos ambientes como en la versión recursiva. Todo el cálculo ocurre dentro del único ambiente creado para la ejecución de fact-iter,que es accesible desde el global, pero no utiliza pilas adicionales.


Cuando se llama a (factorial 6) se invoca a fact-iter con product=1, counter=1, max-count=6. Así serían las iteraciones:

 -Primera iteración: counter=1 ≤ max-count=6, se evalúa: product = (* 1 1) = 1 counter = (+ 1 1) = 2
 -Segunda iteración: counter=2 ≤ max-count=6, se evalúa: product = (* 2 1) = 2 counter = (+ 2 1) = 3
 -Tercera iteración: counter=3 ≤ max-count=6, se evalúa: product = (* 3 2) = 6 counter = (+ 3 1) = 4
 -Cuarta iteración: counter=4 ≤ max-count=6, se evalúa: product = (* 4 6) = 24 counter = (+ 4 1) = 5
 -Quinta iteración: counter=5 ≤ max-count=6, se evalúa: product = (* 5 24) = 120 counter = (+ 5 1) = 6
 -Sexta iteración: counter=6 ≤ max-count=6, se evalúa: product = (* 6 120) = 720 counter = (+ 6 1) = 7
 -Finalización: counter=7 > max-count=6, devuelve product = 720.


En ambas versiones, el ambiente global es solo un lugar donde se almacenan las definiciones de las funciones,
pero en la iterativa se hace un uso mucho más eficiente del ambiente local al evitar la creación de múltiples contextos.
Esto se traduce en menor consumo de memoria. En la versión recursiva, cada llamada a factorial accede al global
para invocar la función y en la iterativa solo se invoca una vez desde el global.
|#

;Ejemplos de uso

(factorial 6)
(factorial2 6)