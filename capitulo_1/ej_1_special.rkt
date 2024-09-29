#lang racket
#|
**Special Exercise**.  Why does this code not work?

```
(define (f x) 
   (let ((a (+ x 10))
         (b (* a 5)))
         (+ a b))
)
(f 2)      ; Fails.  Why?
|#
(define a 3)
(define (f x) 
   (let ((a (+ x 10))
         (b (* a 5)))
         (+ a b))
)

#|
La función definida llamada f da eror debido a que al asignar el valor de b dentro del bloque let, éste depende del valor de a
que está definido en este bloque pero que dentro del let no se puede usar su valor para dar valor a otro u operar con el.
Si por ejemplo le doy un valor a la variable a con
"(define a 3)" fuera del bloque let, el siguiente bloque si funcionaria debido a que esta vez la variable "a" si tiene asignado un valor
de manera global, entonces dentro del bloque let a = 2 + 10, b = 3 * 5 (el valor de a es 3 y no 2 porque no se puede usar el valor de una variable
que defino en el let para otra variable u operar con ell y a = 3 se define fuera del let),
 a + b = 12 + 15 = 27.
|#

(f 2)
;al fallar lo anterior, esto no va a funcionar debido al error que hay con el valor de b.