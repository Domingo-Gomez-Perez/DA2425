#lang racket

#|
**Exercise 1.6**: Alyssa P. Hacker doesn't see why
`if` needs to be provided as a special form.  "Why can't I just define it
as an ordinary procedure in terms of `cond`" she asks.  Alyssa's friend
Eva Lu Ator claims this can indeed be done, and she defines a new version of `if`:

```
(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
```

Eva demonstrates the program for Alyssa:

```
(new-if (= 2 3) 0 5)
5
(new-if (= 1 1) 0 5)
0
```




Delighted, Alyssa uses `new-if` to rewrite the square-root program:

```
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))
```

What happens when Alyssa attempts to use this to compute square roots?
Explain.
|#


(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))




(new-if (= 3 3) 0 5)


(define (good-enough? guess x)
  (< (abs (- x (* guess guess))) 0.001))


(define(improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (* 0.5 (+ x y)))


(define (sqrt-iter guess x)
  (if(good-enough? guess x)                   
          guess                               
          (sqrt-iter (improve guess x) x)))

(sqrt-iter 1 6)

#|

Lo que sucede cuando Alyssa intenta usar esto para raíces cuadradas
es que da un error al llegar a la parte de "good-enough?" debido a
que esa función no está definida, al definirla da otro error en "improve"
debido a que no está definida y pasa lo mismo con "average"
y tras definir estas funciones, lo que ocurre al ejecutar este programa es que se queda en una recursión infinita
al llamar a la función sqrt-iter con los argumentos 1 y 2 debido a que dentro de esta función;
la función new-if que usa el orden aplicativo que hace que se evalúen los 3 argumentos ((good-enough? guess x)                   ;
como predicate, guess como then-clause y (sqrt-iter (improve guess x) x) como else-clause)
antes de que se ejecute esta función (actúa como un if pero no del todo) y el problema ocurre
con el argumento "(sqrt-iter (improve guess x) x)" debido a que al evaluarse este argumento (se evalúan antes
 los argumentos de esta función, orden aplicativo)se llama recursivamente a la función que vuelve a evaluar sus argumentos
 otra vez con el new-if.

Esto sucede con el siguiente código:

define (sqrt-iter guess x)
  (new-if (good-enough? guess x)              ;predicate
          guess                               ;then-clause
          (sqrt-iter (improve guess x) x)))   ;else-clause

Es diferente si se usa el siguiente código:

(define (sqrt-iter guess x)
  (if(good-enough? guess x)                   
          guess                               
          (sqrt-iter (improve guess x) x)))

Lo que sucede si se usa el if en vez de la función new-if es que si la función good-enough?
retorna true (el valor absoluto del cuadrado de guess menos x es menor que 0.001) la función finaliza
retornando el valor de guess y mostrándolo y en caso contrario se llama recursivamente a la función sqrt-iter
(se evalúan antes sus argumentos que no producen ningún bucle infinito) hasta que se cumpla que la función good enough?
devuelva true. Es diferente debido a que en este caso ni "guess" y ni "(sqrt-iter (improve guess x) x))" se evalúan antes
de la comparación, sino que solo se ejecuta o se finaliza porque ya no hay una recursión, si se cumple la condición.

|#





