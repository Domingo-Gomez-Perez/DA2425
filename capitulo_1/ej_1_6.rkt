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

Cuando Alyssa usa su versión de new-if, el problema es que en Scheme los procedimientos 
normales como new-if evalúan todas sus partes antes de decidir cuál usar (forma aplicativa). Esto significa que,
aunque la condición sea verdadera o falsa, tanto el then como el else se calculan primero.


En cambio, el if normal solo evalúa una de las dos ramas (forma normal), dependiendo del resultado de la condición.
 Por eso, con if normal, el programa funciona correctamente, pero con new-if no.
 
 Se podria hacer la comparacion con el AND ya que si el primer argumento es falso el AND es falso tambien no se comprueba
 el segundo argumento.