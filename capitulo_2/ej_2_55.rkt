#lang racket

#|
**Exercise 2.55:** Eva Lu Ator types to the
interpreter the expression

```
(car ''abracadabra)
```
To her surprise, the interpreter prints back `quote`.  Explain.
|#

(car ''abracadabra)
#|
El primer "'" sirve para crear una lista de símbolos con ' y abracadabra.
 Al usar car obtenemos el primer elemento que es "'" y que ya tiene un nombre
reservado en racket que se llama quote que es lo que se muestra
|#


