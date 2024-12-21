# Práctica 3
```
@course Diseño de Algoritmos
@author Grupo D
@version 2024
```
### Pregunta 1
Las dos capitales de estados europeos más proximos entre sí (excluyendo el Vaticano) son Viena y Bratislava.

### Pregunta 2
Véase `pregunta1.rkt`.

### Pregunta 3
#### Complejidad Temporal

La función `min-dist` calcula la distancia mínima entre todos los pares de puntos.

1. **Bucle externo:**  
   - El bucle `loop` recorre la lista `agenda`, con $n$ puntos en total. Esto significa que el bucle externo se ejecutará $n$ veces.

2. **Cálculo de distancias:**  
   - Dentro del bucle, la línea `(map (lambda (p2) (euclidean-distance p1 p2)) (cdr points))` calcula las distancias desde un punto `p1` a todos los puntos restantes en la lista.  
   - Para el primer punto, esto se realiza para $n-1$ puntos, para el segundo punto para $n-2$, y así sucesivamente.  
   - La suma total de operaciones de cálculo de distancia es: $(n-1) + (n-2) + \ldots + 1 = \frac{n(n-1)}{2}$

   - La distancia euclidia en sí tiene complejidad constante $O(1)$, ya que solo implica restas, cuadrados, suma y raíz cuadrada.

3. **Comparaciones para encontrar el mínimo:**  
   - La función `apply min` en cada iteración del bucle es lineal en el número de elementos que está comparando. Sin embargo, ya está incluida en la suma anterior porque procesamos todas las distancias una vez.

Por lo tanto, la complejidad temporal de la función `min-dist` es $O(n^2)$, debido a que calcula todas las distancias posibles entre pares de puntos.

---

#### Complejidad Espacial

1. **Estructura de datos:**  
   - La lista `agenda` con $n$ puntos es la entrada principal. Cada punto es una lista de dos números, lo que ocupa $O(n)$ espacio.

2. **Espacio adicional:**  
   - En cada iteración del bucle, la función `map` genera una lista temporal de distancias, cuyo tamaño decrece con el tamaño de `points`. Sin embargo, en el peor caso, esta lista podría ser de tamaño $n-1$.
   - No hay estructuras adicionales grandes que se mantengan fuera de esta iteración, ya que la lista de distancias se descarta después de encontrar el mínimo.

Por lo tanto, la complejidad espacial es $O(n)$, dominada por la lista `agenda` y las listas temporales de distancias creadas durante la ejecución.

---

#### ¿Iterativo o recursivo?
El algoritmo presentado genera un *proceso iterativo*, no recursivo, aunque utiliza una función que se define recursivamente `(loop)` para lograr la iteración. La función `loop` es una función con recursión de cola. Esto significa que la última operación en cada llamada recursiva es simplemente invocar a loop nuevamente, sin realizar cálculos adicionales después de la llamada recursiva. Como vemos, vamos guardando el nuevo mínimo `new-min` cada vez que llamamos a `loop`. 

### Pregunta 4
Sí, siempre es posible encontrar un $x_0 \in \mathbb{Q}$ que cumpla las condiciones dadas porque:

1. **Conjunto finito y discreto:**  
   Los puntos se encuentran en un conjunto finito, y las coordenadas son valores discretos. Esto permite ordenar los puntos sin ambigüedad.

2. **Ordenamiento por coordenadas $x$:**  
   Al ordenar los puntos según su coordenada $x$, el punto medio puede determinarse de manera directa. 

3. **Separación balanceada:**  
   Al elegir $x_0$ como la coordenada $x$ del punto medio:
   - Los puntos con $x < x_0$ se asignan al subconjunto $P_1$.
   - Los puntos con $x > x_0$ se asignan al subconjunto $P_2$.
   - Si $x = x_0$, se asigna a $P_1$ o $P_2$ para mantener la diferencia de tamaños dentro del rango permitido.

Por lo tanto, el procedimiento es determinista y siempre garantiza que:
$\lvert |P_1| - |P_2| \rvert \leq 1$

### Pregunta 5
Véase `pregunta5.rkt`.

#### Complejidad Temporal
1. **Ordenación de la lista:**
   - La función `sort` utiliza un algoritmo eficiente como **quicksort** o **mergesort**, que tiene una complejidad temporal de $O(n \cdot \log(n))$, donde $n$ es el número de elementos en la lista.

2. **Cálculo de `mid`:**
   - El cálculo de la mitad de la lista es simplemente una división de la longitud de la lista, lo cual es una operación de **complejidad constante** $O(1)$.

3. **Recursión en el bucle `loop`:**
   - La recursión recorre cada elemento de la lista una sola vez, realizando trabajo constante en cada iteración, como la comparación y la inserción en la lista mediante `cons`.
   - La recursión se ejecuta $n$ veces, y en cada recursión, se realizan operaciones de tiempo constante $O(1)$.


Luego la complejidad temporal total es $O(n \cdot \log(n))$ debido a que la ordenación es la dominante.

---

#### Complejidad Espacial
1. **Espacio para la lista ordenada:**
   - La función `sort` crea una nueva lista ordenada, lo que requiere espacio adicional $O(n)$ para almacenar dicha lista.

2. **Espacio para las listas `p1` y `p2`:**
   - Durante la recursión, se agregan elementos a las listas `p1` y `p2` mediante `cons`. Estas listas eventualmente contendrán aproximadamente $n/2$ elementos cada una, por lo que se requiere $O(n)$ espacio adicional para ambas.

3. **Espacio de la pila de recursión:**
   - La recursión tiene una profundidad máxima de $n$, ya que procesa todos los elementos de la lista. El espacio de la pila de recursión es $O(n)$.

Luego la complejidad espacial total es $O(n)$.

### Pregunta 6
Utilizando el teorema maestro, dado que $T(n) \leq 2 \cdot T(\frac{n}{2}) + f(n)$, tenemos que:
- El número de subproblemas es $a = 2$.
- La cantidad por cuánto se divide el tamaño del subproblema es $b = 2$.
- $O(n^c)$ es el coste de descomponer y combinar, es decir, el tiempo necesario para efectuar la partición y construir la solución global a partir de las dos parciales, que viene dado por $f(n)$.

a. **Caso $f(n) = O(n)$**
   - Tenemos que $a = 2 = 2^1 = b^c$, luego, por el teorema maestro, deducimos que la complejidad temporal es $O(n^c \cdot \log(n)) = O(n \cdot \log(n))$.

b. **Caso $f(n) = O(n^2)$**
   - Tenemos que $a = 2 \lt 2^2 = b^c$, luego, por el teorema maestro, deducimos que la complejidad temporal es $O(n^c) = O(n^2)$.

### Pregunta 7
Véase `pregunta7.rkt`. 

### Pregunta 8
Véase `pregunta8.rkt`.

### Pregunta 9
Véase `pregunta9.rkt`.

### Pregunta 10
Véase `pregunta10.rkt`.

### Pregunta 11
La complejidad computacional para encontrar la pareja de puntos más distante (el diámetro del conjunto de entrada) es $O(n \cdot \log(n))$.

1. **Enfoque Ingenuo**:
   - Comparar todas las posibles parejas de puntos tiene una complejidad de $O(n^2)$.
   - Este enfoque no es óptimo.

2. **Enfoque Óptimo**:
   - La pareja más distante siempre pertenece a los puntos que forman la **envolvente convexa** del conjunto.
   - **Pasos del algoritmo**:
     1. Calcular la envolvente convexa en $O(n \cdot \log(n))$ usando algoritmos eficientes como *Graham's scan* o *divide-and-conquer*.
     2. Usar el método de **calibradores rotantes** (*rotating calipers*) para determinar la pareja más distante entre los puntos de la envolvente en $O(h)$, donde $h$ es el número de puntos en la envolvente ($h \leq n$).

   - **Complejidad Total**:
     - Calcular la envolvente: $O(n \cdot \log(n))$.
     - Encontrar la pareja más distante: $O(h)$, con $h \leq n$.
     - Resultado final: $O(n \cdot \log(n))$.
