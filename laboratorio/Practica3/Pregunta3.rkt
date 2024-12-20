#lang racket
;Análisis de Complejidad Temporal
;Función leer-puntos
;Complejidad Temporal de leer-puntos: O(n), donde n es el número de líneas en el archivo.

;2. Función reverseaux y reverse
;Complejidad Temporal de reverse: O(n), donde n es el número de puntos en la lista. Como fue explicado en el ejercicio 2_18

;3. Función distancia-minima2 y buscar-minima
;Esta es la función principal que calcula la distancia mínima entre los puntos.
;Número de iteraciones: En total, se hacen n(n-1)/2 comparaciones de distancias.
;Por lo tanto, la complejidad temporal de distancia-minima2 es O(n2) debido a los dos bucles anidados.


;4. Función main

;La lectura de puntos es O(n).
;La inversión de la lista es O(n).
;El cálculo de la distancia mínima es O(n2).
;Por lo tanto, la complejidad temporal total de main es el cálculo de la distancia mínima: O(n2).



;Análisis de Complejidad Espacial
;1. Espacio utilizado por leer-puntos
;La función leer-puntos devuelve una lista de puntos, por lo que utiliza O(n) espacio donde n es el número de puntos.

;2. Espacio utilizado por reverse
;La función reverse crea una nueva lista que es la inversión de la lista original. La complejidad espacial de reverse es O(n) porque crea una nueva lista de la misma longitud.

;3. Espacio utilizado por distancia-minima2 y buscar-minima
;Dentro de distancia-minima2, la función buscar-minima utiliza llamadas recursivas y pasa sublistas de puntos. Sin embargo, no se crea ninguna nueva estructura de datos que crezca con el tamaño de la entrada. Las listas restantesi y restantesj son sublistas que ocupan espacio proporcional al número de elementos que contienen, pero esto no aumenta el espacio necesario más allá de O(n).

;La pila de recursión también tiene una profundidad de O(n), ya que la recursión avanza por cada punto de la lista.
;Por lo que la complejidad espacial de la funcion es O(n)

;4. Espacio utilizado por la función main
;En main, las variables puntos, puntos2, y la lista devuelta por distancia-minima2 ocupan O(n) espacio, y no hay estructuras de datos adicionales que aumenten significativamente el uso de memoria.

;Conclusión de Complejidad Espacial
;La complejidad espacial total está dominada por las listas de puntos y la pila de recursión, por lo que es O(n).

;Este algoritmo es recursivo, ya que utiliza una función interna recursiva (buscar-minima) para explorar todos los pares de puntos.