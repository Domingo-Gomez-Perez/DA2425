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

#|
2  Cota superior para la cantidad de llamadas a busca_aux
   La búsqueda por bipartición realiza log2(n) llamadas recursivas.
   Complejidad temporal: O(log n)
   Complejidad espacial: O(log n)
|#

#|
3  Cota superior asintótica para la complejidad computacional
   Supongamos que la extensión de la representación binaria de cada uno de los números 
   de la lista está acotada por log2 n.
   Complejidad en términos de operaciones bit: O(log n * log n)
|#

#|
4  Aplicación del teorema maestro
   El teorema maestro se puede aplicar a la complejidad temporal de la búsqueda por 
   bipartición, ya que esta operación tiene una estructura recursiva adecuada.
|#

#|
5  Versión iterativa del algoritmo de búsqueda por bipartición
   (definir el código aquí)
|#
