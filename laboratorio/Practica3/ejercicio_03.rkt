La complejidad espacial de la función que hemos desarrollado es O(n), ya que va a depender siempre proporcional al número de elementos
en la lista. 

En cuanto a la complejidad temporal, podemos calcularla de forma exacta. Como sabemos, el método lo que hace es empezar a recorrer la 
lista de elementos y para cada uno de ellos, calcula su distancia con el resto de la lista. De esta forma, podemos deducir que 
el número de iteraciones de este procedimiento será: (n^2 - n)/2. Por lo tanto la complejidad temporal de nuestro algoritmo de forma 
exacta será: O((n^2 - n)/2)

Por otra parte, se trata un procedimiento recursivo que genera un proceso iterativo, ya que cada vez que se realiza una nueva Llamada
recursiva, se finaliza la actual.