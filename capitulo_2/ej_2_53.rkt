#lang racket

#|
**Exercise 2.53:** What would the interpreter print
in response to evaluating each of the following expressions?

```
(list 'a 'b 'c)
(list (list 'george))
(cdr '((x1 x2) (y1 y2)))
(cadr '((x1 x2) (y1 y2)))
(pair? (car '(a short list)))
(memq 'red '((red shoes) (blue socks)))
(memq 'red '(red shoes blue socks))
```

|#



(list 'a 'b 'c)
#| el usar ' (quote) para cada uno de las variables (a,b,c) en combinacion con list hace que me devuelva una lista de símbolos (a,b,c)
  debido al quote, si alguno no tuviese "'" daría un error debido estos símbolos no son interpretados directamente por racket,
se muestra lo siguiente:

" '(a b c) "
|#

(list (list 'george))

#| el usar ' (quote) para  george hace que me interprete esto como un símbolo y un elemento de una lista que está dentro de otra lista:
" '((george)) "

|#

(cdr '((x1 x2) (y1 y2)))

#| el usar ' (quote) juntos los paréntesis
 me sirve para crear una lista sin necesidad de usar list dentro de cada paréntesis y además me permite crear ua lista de símbolos
 sin necesidad de que tengan una valor definido y al usar cdr en combinación del
 símbolo quote hace que me devuelva el resto de la lista excepto el primer elemento:
 "'((y1 y2))"
|#


(cadr '((x1 x2) (y1 y2)))
#| el usar ' (quote) juntos a los paréntesis
 me sirve para crear una lista sin necesidad de usar list dentro de cada paréntesis y al usar cadr en combinación del
 símbolo quote hace que me devuelva el primer elemento del resto de la lista restante sin el elemento inicial anterior:
 "'(y1 y2)"
|#

(pair? (car '(a short list)))

#| el usar ' (quote)  me sirve para crear una lista sin necesidad de usar list dentro de cada paréntesis y además me permite
 crear una lista de símbolos sin necesidad de que tengan una valor definido y al hacer "(car '(a short list))" me devuelve un
símbolo en cominación con quote y es cuando se comprueba si esto es una lista de pares (evaluandose como si fuera una lista formada por cons)
, y como no es cierto, me devuelve "#f"
que indica que no se cumple
|#

(memq 'red '((red shoes) (blue socks)))


#|
El uso de memq me permite que dada una lista (hecha por el uso de ' y paréntesis) con otras sublistas que tienen elementos
(red, shoes, blue, socks), evaluar si un cierto símbolo definido con quote ('red) está en la lista definida, en caso de cumplirse
lo que devuelve son los elementos que se encuentran en esa lista y en las sublistas, además del propio símbolo
 (no se evalúa para sublistas,solo para la lista que está más afuera)a partir de la posición desde donde se encontró
ese elemento ('red), en este caso como en la lista de fuera no hay ningun símbolo 'red, devuelve:
"#f" 


 
|#


(memq 'red '(red shoes blue socks))


#|
El uso de memq me permite que dada una lista (hecha por el uso de ' y paréntesis) con otras sublistas que tienen elementos
(red, shoes, blue, socks), evaluar si un cierto símbolo definido con quote ('red) esta en la lista definida (no se evalúa para sublistas,
solo para la lista que está más afuera), en caso de cumplirse
lo que devuelve son los elementos que se encuentran en esa lista y en las sublistas 
 a partir de la posición desde donde se encontró ese elemento ('red), en este caso como en la lista de fuera si hay un símbolo 'red, devuelve
todos los elementos de la lista y sublistas desde donde se encontró además del propio simbolo:

'(red shoes blue socks)


|#