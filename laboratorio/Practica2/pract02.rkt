#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA
|#

#|
1  Traducción del código dado de Python a Scheme
   Utilizando listas y que también sea válido para vectores.
   (definir el código aquí)
|#

(define (list-ref lista n)
  (if (zero? n)
      (car lista)     ; Si n es 0, retornamos el primer elemento (car).
      (list-ref (cdr lista) (- n 1))))  ; Si n > 0, avanzamos recursivamente con (cdr) y reducimos n.

(define (length lista)
  (if (null? lista)
      0
      (+ 1 (length (cdr lista)))))

(define (busca x ed)
  (busca-aux x ed 0 (length ed)))

(define (busca-aux x ed i j)
  (if (>= i j)
      -1
      (let ((m (quotient (+ i j -1) 2)))
        (let ((elem (if (list? ed)
                        (list-ref ed m)
                        (vector-ref ed m))))
          (cond ((= elem x) m)  ; si encontramos el elemento, retornamos el índice
                ((< elem x) (busca-aux x ed (+ m 1) j))  ; buscar en la mitad superior
                (else (busca-aux x ed i m)))))))  ; buscar en la mitad inferior

#|
2  Calcula una cota superior para la cantidad de llamadas a busca_aux que realiza el algoritmo
en función de la longitud de la lista de entrada. Acota la complejidad espacial y temporal de la
búsqueda por bipartición.



La función busca_aux realiza una búsqueda en un array ordenado dividiéndolo a la mitad en cada llamada recursiva.
Por lo que  el tamaño de la lista en la siguiente llamada será aproximadamente n/2. Así la cantidad de llamadas es:

La primera llamada se realiza con n elementos.
La segunda llamada se realiza con n/2 elementos.
La tercera llamada se realiza con n/4 elementos.
Y así sucesivamente...

Sabiendo esto podemos calcular tanto la complejidad temporal como espacial.

Complejidad temporal en el peor caso:
La complejidad temporal de la búsqueda por bipartición es O(log2 n)
Esto lo hemos hallado con el teorema maestro explicado mas abajo.

Complejidad espacial en el peor caso:
La complejidad espacial se refiere a la cantidad de espacio adicional que utiliza el algoritmo.
En este caso, debido a ser recursivo, cada llamada recursiva ocupa espacio en la pila de llamadas.

Si pensamos en la complejidad temporal como lo que ocupa la lista, ocupa O(n).
Si lo pensamos como la cantidad de espacio que ocupa la pila recursiva, en el peor caso
iremos llamando a recursion hasta llegar a la mitad. En total haremos: O(log2 n)
|#

#|
3  Suponiendo que la extensión de la representación binaria de cada uno de los números de la lista
está acotada por log2 n, deduce una cota superior asintótica para la complejidad computacional
del algoritmo en términos de operaciones bit


Ya hemos calculado que la complejidad de todo el algoritmo es O(log2 n) en el peor caso.
Ahora tenemos que añadir las operaciones de bit. En el peor caso, tendremos 5 operaciones de bit:
       m = (i + j - 1) >> 1 Restar 1 y Desplazamiento
        if lista[m] == x: Mirar si son iguales
            return m
        elif lista[m] < x: Mirar si es menor
            return busca_aux(x, lista, m + 1, j) Sumar 1

Y esto hay que hacerlo en cada recursion. Por lo que en total tendremos O(log2 n) * 5 * O(log2 n)
En total nos queda O(log2 n)^2.
|#

#|
4  Aplicación del teorema maestro
   El teorema maestro se puede aplicar a la complejidad temporal de la búsqueda por
   bipartición, ya que esta operación tiene una estructura recursiva adecuada.


Si, podemos aplicar el teorema maestro.
Para ello, habría que hallar los valores de a, b y f(n).

En relación con el segundo apartado, se puede aplicar de la siguiente manera:
  a = 1: Solo hay un subproblema.
  b = 2: La longitud del problema es n / 2
  f(n)= θ(1): El coste de dividir el problema es constante.

Al aplicar el teorema, observamos que logb a = log2 1 = 0, y el coste f(n) = θ(1) = n^0.
Esto nos lleva al segundo caso del teorema, donde f(n)= θ(n^(logb a) ) = θ(n^0 ).
Por lo tanto, la complejidad temporal es:
T(n)= θ(n^(log2 1) * log ⁡n )= θ(log ⁡n)

En relación con el tercer apartado, se puede aplicar de la siguiente manera:
  a = 1: Solo hay un subproblema.
  b = 2: La longitud del problema es n / 2
  f(n)= θ(log ⁡n): El coste de dividir el problema implica comparar números de θ(log ⁡n) bits.

Al aplicar el teorema, observamos que logb a = log2 1 = 0, pero en este caso f(n) = θ(log ⁡n), siendo mayor que n^0 = 1.
Por ello, nos encontramos ante el tercer caso del teorema, donde f(n) = Ω(n^(log2 1) ) y
se cumple la condición de regularidad (es decir, a * f(⌈n/b⌉) ≤ c * f(n) para algún c < 1).
Por lo tanto, el coste total está dominado por f(n), y la complejidad es:
T(n)= θ(log ⁡n )* θ(log ⁡n) = θ(log^2 ⁡n)
|#


#|
5  Versión iterativa del algoritmo de búsqueda por bipartición
aunque se llame a el mismo, funciona como iterativo realmente.
|#


(define (busca-iter x lista)
  (define (aux i j)
    (if (> i j)
        -1  ; Elemento no encontrado
        (let* ((medio (quotient (+ i j) 2))  ; Índice medio
               (valor-medio (list-ref lista medio)))
          (cond
            ((= valor-medio x) medio)  ; Elemento encontrado
            ((< valor-medio x) (aux (+ medio 1) j))  ; Ignorar mitad izquierda
            (else (aux i (- medio 1)))))))  ; Ignorar mitad derecha
  (aux 0 (- (length lista) 1)))



; casos de prueba

(define lista-ordenada (list 1 3 5 7 9 11 13))
(define lista-ordenada2 (list 2))
(define lista-ordenada3 (list))

(let* ((resultado (busca 1 lista-ordenada))
       (resultado2 (busca-iter 1 lista-ordenada)))
  (display (string-append (number->string resultado) " y " (number->string resultado2))) (newline))

(let* ((resultado (busca 13 lista-ordenada))
       (resultado2 (busca-iter 13 lista-ordenada)))
  (display (string-append (number->string resultado) " y " (number->string resultado2))) (newline))

(let* ((resultado (busca 7 lista-ordenada))
       (resultado2 (busca-iter 7 lista-ordenada)))
  (display (string-append (number->string resultado) " y " (number->string resultado2))) (newline))

(let* ((resultado (busca 15 lista-ordenada))
       (resultado2 (busca-iter 15 lista-ordenada)))
  (display (string-append (number->string resultado) " y " (number->string resultado2))) (newline))

(let* ((resultado (busca 8 lista-ordenada))
       (resultado2 (busca-iter 8 lista-ordenada)))
  (display (string-append (number->string resultado) " y " (number->string resultado2))) (newline))

(let* ((resultado (busca 2 lista-ordenada3))
       (resultado2 (busca-iter 2 lista-ordenada3)))
  (display (string-append (number->string resultado) " y " (number->string resultado2))) (newline))

(let* ((resultado (busca 2 lista-ordenada2))
       (resultado2 (busca-iter 2 lista-ordenada2)))
  (display (string-append (number->string resultado) " y " (number->string resultado2))) (newline))


; PROGRAMAR EL WHILE EN SHEME (ejercicio extra 0.25 en el examen)

(define (while test orden)
  (if (test) ; Si la condición es verdadera
      (begin
        (orden) ; Ejecuta el cuerpo
        (while test orden)) ; Llama recursivamente
      (void))) ; Sale del bucle si la condición es falsa


; prueba de que funciona
(define contador 0)

(define (test) (< contador 5))

(define (orden)
  (begin
    (display contador) ; Muestra el contador
    (newline)          ; Salto de línea
    (set! contador (+ contador 1)))) ; Incrementa el contador

(while test orden) ; Inicia el bucle