#lang racket
(define (busca x estructura)
  (busca_aux x estructura 0 (last-pos-struct estructura)))

(define (busca_aux x estructura i j)
  (define pos (truncate (/ (- (+ i j) 1) 2)))
  (define elem (posicion estructura pos))
  (if (>= i j) null
      (cond ((= elem x) pos)
            ((< elem x) (busca_aux x estructura (+ pos 1) j))
            (else (busca_aux x estructura i pos))
            )
      )
  )
  
(define (last-pos-struct estructura)
  (if (pair? estructura)
      (last-pos-list estructura 1) (vector-length estructura)))

(define (last-pos-list list i)
  (if (null? (cdr list)) i (last-pos-list (cdr list) (+ i 1))))

(define (posicion estructura i)
  (if (pair? estructura) (elem-lista-enlazada estructura i) (vector-ref estructura i)))

(define (elem-lista-enlazada celda i)
  (if (= i 0) (car celda) (elem-lista-enlazada (cdr celda) (- i 1))))



#|
2 .Calcula una cota superior para la cantidad de llamadas a busca_aux que realiza el algoritmo en función de la longitud de la lista de entrada.
Acota la complejidad espacial y temporal de la búsqueda por bipartición.

Como el algoritmo va dividiendo el problema en 2, en el peor de los casos tiene que hacer log2n = O(log2n)
dado que tiene que dividir todo el array hasta llegar a una lista de tamaño 1.
La complejidad espacial es la misma que la temporal ya que la pila tiene que almacenar las llamadas recursivas.

3. Suponiendo que la extensión de la representación binaria de cada uno de los números de la lista está acotada por log2 n,
deduce una cota superior asintótica para la complejidad computacional del algoritmo en términos de operaciones bit.

Asumiendo que cada bit requiere una comparación, entonces tendremos que hacer log n comparaciones por cada número
y por tanto para cada llamada recursiva ya que se requiere hacer una comparación para ver si es igual, mayor o menor.
Aunque en el código se vean explícitamente dos comparaciones, asumimos que que hay registros con flags
que guardan el resultado de la comparación con diferentes flags y que no hace falta comparar 2 veces.
Entonces el numero de operaciones será igual a (log_2 n)^2 debido a que se hacen log_2 n comparaciones por cada llamada recursiva y se hacen log_2 n llamadas.

4. ¿Se puede aprovechar el teorema maestro para las dos preguntas anteriores?
En el caso de la pregunta 2 se puede aprovechar al completo, ya que el teorema maestro
sirve para calcular la complejidad temporal de un algoritmo recursivo por sustitución de algunos parámetros.
Si podemos sustituir los parámetros a, b y c según la función T(n)=a T(n/b)+O(n^c)= 1 T(n/2)+O(n^0),
el teorema maestro nos dice que la complejidad en este caso es O(log_2 n), que coincide con la respuesta.
Para la pregunta 3 se puede aplicar para el mismo algoritmo pero no para las operaciones bit,
ya que este algoritmo no es recursivo sino lineal.

5. Escribe una versión iterativa del algoritmo de búsqueda por bipartición, dado arriba en forma recursiva
Como se utiliza recursión de cola (la llamada recursiva es lo último que se hace) entonces es tambien iterativo
|#

