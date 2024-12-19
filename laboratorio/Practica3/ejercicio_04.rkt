No siempre vamos a poder encontrar un punto x tal que una recta vertical que pase por ese punto separe una nube de puntos en dos conjuntos 
P1 y P2 tal que ||P1| - |P2|| <= 1. Estoes así ya que:

El planteamiento de dividir los puntos en dos sublistas con un número de puntos balanceado (es decir, |P1| - |P2| ≤ 1) mediante una línea vertical
pasa por encontrar un valor x0 tal que los puntos de la nube a la izquierda de la línea (es decir, x < x0) y los de la derecha (es decir, x > x0) 
estén equilibrados. Sin embargo, esto no siempre es posible debido a:

Puntos con el mismo valor de x: Si varios puntos tienen el mismo valor de x, no podemos decidir de manera clara a qué conjunto deben pertenecer solo
usando la coordenada x. Por ejemplo, si tenemos 5 puntos con el mismo valor de x y otros puntos con valores distintos de x, no podemos trazar una 
línea vertical que divida esos 5 puntos de manera equitativa en dos sublistas. Además, el criterio para separa los puntos respecto de la recta, 
es si x_i<x_0 o si x_i>x_0, no contenplándose que hacer en caso de que x_0 = x_i.


Ejemplo:
Si tenemos una nube de puntos como esta:
(1, 2), (1, 3), (1, 4), (5, 6), (7, 8), (10, 10),
donde tres puntos tienen x = 1 y los otros tienen x distintos, no hay un valor de x0 que divida estos puntos en dos conjuntos equilibrados en número.

Conclusión:
La división de los puntos en dos conjuntos balanceados a lo largo de una línea vertical x0 no siempre es posible, 
especialmente cuando hay múltiples puntos con el mismo valor de x, lo que crea ambigüedad en la asignación de puntos a los conjuntos.
