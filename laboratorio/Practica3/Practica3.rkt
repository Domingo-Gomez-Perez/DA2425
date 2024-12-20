; 1) Prescindiendo de la ciudad del Vaticano, ¿cuáles son las dos
;     capitales de estados europeos más próximas entre sí?

;Las capitales más proximas son viena y bratislava.


; 3) Estima la complejidad espacial y temporal de ese algoritmo. ¿Genera un proceso recursivo o
 iterativo?

; Complejidad Temporal
; 1. Función cargar-puntos:
;    Procesa cada línea del archivo de manera secuencial y realiza operaciones constantes
;    como dividir cadenas y convertirlas en números. Su complejidad temporal es O(n),
;    donde n es el número de líneas en el archivo.
;
; 2. Función invertir-lista:
;    La inversión de la lista se realiza recorriendo todos los elementos de la misma una sola vez,
;    lo que resulta en una complejidad temporal de O(n), siendo n el número de puntos.
;
; 3. Funciones distancia-mas-corta y evaluar-distancia:
;    Estas funciones calculan las distancias entre todos los pares posibles de puntos.
;    El número total de comparaciones es n(n-1)/2, lo que lleva a una complejidad temporal de O(n^2).
;
; 4. Función principal:
;    Combina las operaciones de lectura, inversión y cálculo de distancias, dominadas
;    por el cálculo de distancias. Por lo tanto, la complejidad total es O(n^2).

; Complejidad Espacial
; 1. Función cargar-puntos:
;    Almacena los puntos en una lista que ocupa O(n) espacio.
;
; 2. Función invertir-lista:
;    Genera una nueva lista que ocupa el mismo tamaño que la original, es decir, O(n).
;
; 3. Funciones distancia-mas-corta y evaluar-distancia:
;    La pila de recursión y las sublistas utilizadas ocupan O(n) espacio en el peor caso.
;
; 4. Función principal:
;    Las estructuras de datos utilizadas (listas de puntos y resultados) ocupan O(n) espacio.
;
; En resumen:
; La complejidad temporal total del programa es O(n^2) debido a la comparación entre pares de puntos.
; La complejidad espacial es O(n), ya que las listas y la pila de recursión dominan el uso de memoria.
;
; Genera un proceso RECURSIVO ya que la función evaluar-distancia se llama a si misma 
;para explorar todas las combinaciones de puntos y calcular la distancia mínima.

;4) Planteamos la separación de la nube de puntos según que
;den a la izquierda o a la derecha de cierta recta vertical,
;es decir, escogemos x0 ∈ Q y adscribimos a P1 los puntos
;(x, y) que cumplan x < x0 y a P2 los que cumplan x > x0.
;¿Siempre podemos encontrar x0 ∈ Q de modo tal que es
;te sistema reparta todos los puntos de la lista inicial en
;sublistas con |P1| − |P2| ≤ 1?


;; Sí, siempre es posible garantizar que las sublistas P1 y P2 estén balanceadas,
;; cumpliendo que |P1| - |P2| <= 1.
;; 
;; Esto se logra ordenando los puntos por su coordenada x y seleccionando x0 como 
;; la coordenada x del punto en la posición media de la lista. Los puntos con x <= x0 
;; se asignan a P1 y los que tienen x > x0 a P2. Si el número de puntos es impar, 
;; uno de los subconjuntos tendrá un punto más, pero la diferencia siempre será como máximo 1.
;; Este método garantiza una división válida y balanceada en cualquier caso.

;6) Utilizando el teorema maestro, estima la complejidad del algoritmo en los dos casos siguientes:
; Caso a) f(n) = Θ(n):**
; En este caso, la relación de recurrencia para el algoritmo es:
;   T(n) = 2T(n/2) + Θ(n)
; Aplicando el Teorema Maestro:
;   - a = 2 (número de subproblemas)
;   - b = 2 (factor de división del problema)
;   - f(n) = Θ(n), que corresponde a la combinación.
;   - log_b(a) = log_2(2) = 1.
; Comparando log_b(a) con el exponente de f(n), ambos son iguales, 
; por lo que estamos en el caso 2 del Teorema Maestro. 
; La complejidad final es Θ(n log n).
;
; Caso b) f(n) = Θ(n^2):**
; En este caso, la relación de recurrencia para el algoritmo es:
;   T(n) = 2T(n/2) + Θ(n^2)
; Aplicando el Teorema Maestro:
;   - a = 2, b = 2, f(n) = Θ(n^2).
;   - log_b(a) = log_2(2) = 1.
; Comparando log_b(a) = 1 con el exponente de f(n), que es 2, 
; f(n) domina la recurrencia. Estamos en el caso 1 del Teorema Maestro.
; La complejidad final es Θ(n^2).