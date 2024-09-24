#lang racket

#|
**Special Exercise**.  What answer is given by the following code?  Can you explain it?

```
(define x 5)
(+ (let ((x 3))
        (+ x (* x 10)))
   x)
```
|#

(define x 5)


(+ (let ((x 3))
        (+ x (* x 10)))
   x)

(+ (let ((x 3))(+ 3 30))
  5)

#|
El resultado es 38 debido a que el valor de x dentro del bloque let es 3 y al hacer las operaciones dentro del bloque,
el número rsultante es el de multiplica 3 * 10 = 30 y sumar este más 3, entonces quedaría 33. Y al salir del bloque let,
el valor de x es 5, es como si dentro del let, x fuera como una variable local y fuera el valor de x fuera una variable global.
Entonces al número 33 se le suma 5 (valor de x fuera del bloque let) y da como resultado 38.

(+ (let ((x 3))(+ 3 (* 3 10)))
  5)

(+ (let ((x 3))(+ 3 30))
  5)

(+ 33 5)

|#