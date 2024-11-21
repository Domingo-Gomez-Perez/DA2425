#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.9: Will discuss as a group. In 1.2.1 we used the substitution model to analyze two procedures 
for computing factorials, a recursive version

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
and an iterative version

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
Show the environment structures created by evaluating (factorial 6) using each version of the factorial procedure.
|#

Version recursiva:

Llamada inicial (n = 6): El entorno para la llamada factorial(6) se crea con la variable n 
establecida en 6. Luego, se hace una llamada recursiva con n-1.

Llamadas sucesivas: Cada vez que se hace una llamada recursiva, se crea un nuevo entorno 
con el valor de n decreciendo hasta que n = 1.

Entornos: Cada llamada crea un nuevo entorno (un nuevo cuadradito) que 
contiene una variable n con su valor correspondiente. Esto ocurre hasta que se llega 
al caso base n = 1, donde se comienza a devolver el valor y se resuelven todas las 
llamadas recursivas anteriores haciendo backtracking.
_________________________________________________
| factorial: <procedure>                  Globals |
|   ___________________________________________   |
|  | n: 6                              call 1  |  |
|  |   ____________________________________    |  | 
|  |  | n: 5                        call 2 |   |  |
|  |  |   _______________________________  |   |  |
|  |  |  | n: 4                   call 3 | |   |  |
|  |  |  |   __________________________  | |   |  |
|  |  |  |  | n: 3            call 4   | | |   |  |
|  |  |  |  |   _____________________  | | |   |  |
|  |  |  |  |  | n: 2         call 5 | | | |   |  |
|  |  |  |  |  |   ________________  | | | |   |  |
|  |  |  |  |  |  | n: 1    call 6 | | | | |   |  |
|  |  |  |  |  |  |________________| | | | |   |  |
|  |  |  |  |  |_____________________| | | |   |  |
|  |  |  |  |__________________________| | |   |  |
|  |  |  |_______________________________| |   |  |
|  |  |____________________________________|   |  |
|  |___________________________________________|  |
|_________________________________________________|


Version Iterativa:

Inicialización:
El primer entorno tiene las variables inicializadas: product = 1, counter = 1, y max-count = 6 
(el número factorial queremos calcular). Esta es la configuración inicial antes de comenzar la iteración.

Primera Iteración:
En la siguiente iteración, counter pasa a ser 2. El producto se multiplica por counter, 
es decir, 1 * 1 = 1. Así que ahora product = 1 y counter = 2.

Segunda Iteración:
En esta iteración, counter se incrementa a 3. El valor del product se multiplica por counter, 
es decir, 1 * 2 = 2. Ahora, product = 2 y counter = 3.

Tercera Iteración:
El contador se incrementa nuevamente a 4, y el valor del product se multiplica por counter:
2 * 3 = 6. Ahora, product = 6 y counter = 4.

Cuarta Iteración:
El contador ahora es 5, y el product se multiplica por counter:
6 * 4 = 24. Por lo tanto, product = 24 y counter = 5.

Quinta Iteración:
En esta iteración, el contador es 6. El product se multiplica por counter:
24 * 5 = 120. Ahora, product = 120 y counter = 6.

Sexta Iteración (Final):
En la última iteración, counter se incrementa a 7. El product se multiplica por counter:
120 * 6 = 720, lo cual es el resultado final de factorial(6).

Como tenemos TCO, en cada momento solo va a existir a demas del entorno global, un solo entorno
de fact-iter y este se irá reutilizando a medida que avancemos de iteracion.
Por lo tanto, no desperdiciamos casi memoria y se comporta como un bucle tradicional. (Explicacion abajo)

Para ver bien los entornos creados, haremos que no se eliminan al final de cada iteracion
para ver como queda en el total.

 ____________________________________________
| factorial: <procedure>       Globals       |
|____________________________________________|
|                                            |
|  ________________________________________  |
| | fact-iter: <procedure>       Iter1      | |
| |  ____________________________________   | |
| | | product: 1  counter: 1   max-count: 6 | | |
| | |_____________________________________| | | |
|  ________________________________________  |
| | fact-iter: <procedure>       Iter2      | |
| |  ____________________________________   | |
| | | product: 2  counter: 2   max-count: 6 | | |
| | |_____________________________________| | |
|  ________________________________________  |
| | fact-iter: <procedure>       Iter3      | |
| |  ____________________________________   | |
| | | product: 6  counter: 3   max-count: 6 | | |
| | |_____________________________________| | |
|  ________________________________________  |
| | fact-iter: <procedure>       Iter4      | |
| |  ____________________________________   | |
| | | product: 24 counter: 4   max-count: 6 | | |
| | |_____________________________________| | |
|  ________________________________________  |
| | fact-iter: <procedure>       Iter5      | |
| |  ____________________________________   | |
| | | product: 120 counter: 5  max-count: 6 | | |
| | |_____________________________________| | |
|  ________________________________________  |
| | fact-iter: <procedure>       Iter6      | |
| |  ____________________________________   | |
| | | product: 720 counter: 6   max-count: 6| | |
| | |_____________________________________| | |
|____________________________________________|

Iteración 1:
  - Cuenta: 1 * 1 = 1
  - Apunta a `fact-iter: <procedure>`

Iteración 2:
  - Cuenta: 1 * 2 = 2
  - Apunta a `fact-iter: <procedure>`

Iteración 3:
  - Cuenta: 2 * 3 = 6
  - Apunta a `fact-iter: <procedure>`

Iteración 4:
  - Cuenta: 6 * 4 = 24
  - Apunta a `fact-iter: <procedure>`

Iteración 5:
  - Cuenta: 24 * 5 = 120
  - Apunta a `fact-iter: <procedure>`

Iteración 6:
  - Cuenta: 120 * 6 = 720
  - Apunta a `fact-iter: <procedure>`







ponerlo como lo del recursivo que dice que no se elimina hasta acabar el ambiente

Como vemos, tenemos dos casos distintos:

Versión Recursiva:
La versión recursiva estándar de factorial (como la que usas en el primer código) sigue creando 
un nuevo entorno en cada llamada a la función. Esto ocurre porque cada llamada recursiva espera 
a que se complete la siguiente antes de hacer el cálculo final. Como no hay optimización de cola, 
cada entorno de llamada se acumula en la pila de ejecución.

Versión Iterativa:
A pesar de que la versión iterativa parece un bucle, no crea entornos de ejecución "finales" 
de manera inmediata. En esta versión, la llamada recursiva a fact-iter se realiza como última
operación, lo que permite que si el lenguaje soporta la optimización de cola (TCO), 
los entornos de llamada se reutilicen en lugar de acumularse. Esta es una característica
esencial para evitar el crecimiento de la pila de ejecución, como sucedería en la versión recursiva.

Tail-call optimization:
Con TCO: La versión iterativa no acumula entornos y es tan eficiente como un bucle tradicional.
Sin TCO: Aunque la versión iterativa usa recursión, los entornos se acumulan de manera similar 
a la recursiva, lo que resulta en una entorno dentro de otro.

https://www.reddit.com/r/scheme/comments/kjof0o/noob_question_is_tailcall_optimization_still/
https://www.cs.utexas.edu/ftp/garbage/cs345/schintro-v14/schintro_127.html#:~:text=Also%20notice%20that,call%20optimization%20yourself.
https://scheme.com/tspl4/further.html#:~:text=As%20we%20discussed,of%20recursion%20stack.
https://scheme.com/tspl4/intro.html#:~:text=As%20with%20procedures,scoped%20syntactic%20extensions.