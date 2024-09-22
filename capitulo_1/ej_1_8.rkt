#lang racket

#|
**Exercise 1.8**: Newton's method for cube roots is
based on the fact that if `y` is an approximation to the cube root of `x`,
then a better approximation is given by the value

```
x/y^2 + 2y
----------
    3
```

Use this formula to implement a cube-root procedure analogous to the
square-root procedure.  In section 1.3.4 we will see how to implement
Newton's method in general as an abstraction of these square-root and cube-root
procedures.)
|#


(define (good-enough? guess x)
  (< (abs (- x (* guess guess guess))) 0.001))


(define(improve guess x)
  (division (/ x (* guess guess))(* 2 guess)))

(define (division x y)
  (/ (+ x y) 3))
 

(define (cubic-iter guess x)
  (if (good-enough? guess x)                   
          guess                               
          (cubic-iter (improve guess x) x)))


(cubic-iter 5 125)

(cubic-iter 1 8)




;Este método cubic-iter es un método análogo al de sqrt-iter con la diferencia de
;que comprobamos si el valor de guess es aproximadamente la raiz cúbica del valor de x
;y vemos si es suficientemente bueno si es menor que 0.001
