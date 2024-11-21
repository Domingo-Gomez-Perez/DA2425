Complejidad temporal
El algoritmo implementado busca los puntos más cercanos en una lista de puntos, calculando la distancia entre cada par de puntos. 
Esto implica comparar todos los puntos entre sí. En cada llamada recursiva se realiza una comparación de distancias, 
lo que puede considerarse un algoritmo cuadrático en términos de complejidad temporal (todos con todos).

    Detalle de la complejidad:
    Para cada punto en la lista (tiene n puntos), se comparan con todos los demás puntos.
    En total, se realizan n*(n-1)/2 comparaciones de distancias, lo que da una complejidad temporal de O(n²).
    Por lo tanto, la complejidad temporal es O(n²). La expresión exacta es (n² - n)/2, pero en notación Big-O se simplifica a O(n²).

Complejidad espacial
La complejidad espacial depende del espacio necesario para almacenar los datos y las llamadas recursivas. El algoritmo mantiene una
lista de puntos, y la recursión maneja la lista de puntos restantes:

La espacialidad del algoritmo está dominada por el almacenamiento de la lista de puntos y las variables adicionales que se pasan a 
través de las funciones recursivas.
En cada nivel de recursión, solo se almacena una pequeña cantidad de variables locales, y las listas de puntos no se duplican, por
lo que la complejidad espacial está directamente relacionada con el número de puntos en la lista.
Por lo tanto, la complejidad espacial es O(n), ya que la lista de puntos y los resultados intermedios se almacenan en memoria.

Naturaleza recursiva del algoritmo
Este algoritmo es recursivo debido a que se define con llamadas a sí mismo para recorrer las listas de puntos y calcular las distancias.
Sin embargo, cada llamada recursiva se procesa completamente antes de que se realice la siguiente llamada, lo que da la apariencia de
un proceso iterativo. En otras palabras, la recursión se utiliza para manejar las iteraciones a través de la lista, pero no se realizan
múltiples pasos concurrentes dentro de cada llamada recursiva, lo que hace que la recursión sea como un bucle tradicional.

En resumen:

Complejidad temporal: O(n²), porque hay que hacer una comparación de distancias para cada par de puntos.
Complejidad espacial: O(n), porque el espacio requerido para almacenar los puntos es proporcional al tamaño de la lista.
El algoritmo es recursivo, pero implementa un proceso que se asemeja a un bucle iterativo a través de los puntos.