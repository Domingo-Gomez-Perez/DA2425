#lang racket
#|
El diámetro de un conjunto de puntos es la distancia máxima entre dos puntos dentro de ese conjunto. 
Este problema, conocido como la búsqueda de la pareja más distante, resuelve, en particular, el cálculo del diámetro.

**Análisis de la complejidad:**

La búsqueda de la pareja más distante es conceptualmente similar a la de la pareja más próxima, 
pero se busca maximizar la distancia entre puntos en lugar de minimizarla.  
Para resolver este problema, una solución facil consiste en comprobar todas las combinaciones de
parejas de puntos. Esto tiene una complejidad de O(n^2), ya que implica evaluar binom{n}{2} distancias.
Sin embargo, este enfoque no es eficiente para grandes conjuntos de puntos.  

**Optimización usando el casco convexo:**

El diámetro de un conjunto siempre está definido por dos puntos que forman parte del casco convexo, ya 
que los puntos interiores del conjunto no contribuyen a la distancia máxima.  
Calcular el casco convexo de un conjunto de n puntos puede hacerse en On log n utilizando algoritmos 
como Graham Scan o Jarvis March.  

**Calíperes giratorios:**

Una vez obtenido el casco convexo, el problema de encontrar la pareja más distante se reduce a examinar
las parejas de puntos del casco convexo, lo cual puede hacerse en O(n) usando el algoritmo de calíperes giratorios.  
Este método consiste en recorrer los vértices del casco convexo y calcular las distancias entre puntos opuestos, 
garantizando una búsqueda eficiente.  

**Conclusión:**

Combinando ambas técnicas, la complejidad de la búsqueda de la pareja más distante es O(nlog n),
Donde lo mas costoso computacionalmente es el calculo del casco convexo.
|#
