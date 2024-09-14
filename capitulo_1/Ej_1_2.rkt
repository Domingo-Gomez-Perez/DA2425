#lang racket

#|

**Exercise 1.2:** Translate the following expression into prefix form:

```
5 + 4 + (2 - (3 - (6 + 4/5)))
-----------------------------
       3(6 - 2)(2 - 7)
```
|#

#|
5 + 4 + (2 - (3 - (6 + 4/5))); se realiza primero la
suma de 6 + 4/5, después se hace la diferencia entre 3 y ese resultado
; a continuación se hace la resta entre 2 y este otro resultado; y finalmente
se suma este valor con 5 y 4; dando como resultado 14.8


|#
(+ (+ 5 4) (- 2(- 3(+ 6(/ 4 5))))) ;debe dar 74 / 5 = 14.8



#|
3(6 - 2)(2 - 7), se realiza en primer lugar las restas de los paréntesis
y luego se mutiplican ambos resultados y finalmente ese resultado se multiplica
por 3, dando como resultado -60
|#
(* 3 (*(- 6  2)) (- 2 7))