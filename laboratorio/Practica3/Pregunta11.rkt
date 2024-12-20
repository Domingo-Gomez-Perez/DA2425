#lang racket
#|
El problema que se nos ha planteado es calcular la complejidad computacional de la busqueda de la pareja mas distante. Existen varias maneras de hacerlo:

Por un lado podriamos calcular la distancia entre todas las posibles parejas de puntos, sin embargo, esto resultaria en una complejidad temporal  de 0(n^2),
esto es debido a que hay n^2 combinaciones posibles.

Otra manera mucho mas eficiente es la optimizacion mediante el casco convexo, una funcion parecida a la del ejercicio 8 de esta practica pero tomando la
los puntos que no esten dentro de la lambda obtenida ya que estos puntos estaran siempre a una distancia mayor que los de dentro. Este metodo consta de
2 apartados.

Primero deberemos calcular el casco convexo, en este caso al haber n puntos se puede calcular en 0(n*log*n). Despues de obtener el casco convexo (el cual va
a tener h vertices y h siempre va a ser menor que n) deberemos buscar el diametro usando las parejas mas alejadas entre si. Este proceso es 0(h).

Como podemos observar, el calculo del casco convexo es la parte mas costosa del proceso ya que tiene complejidad 0(n*log*n) y ya que el calculo de las parejas
mas alejadas es 0(h) y (h<n) nos va a dar como resultado un coste temporal total de 0(n*log*n)
|#