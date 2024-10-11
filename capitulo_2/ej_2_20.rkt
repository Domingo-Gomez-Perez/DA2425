#lang racket

#|
**Exercise 2.20:** The procedures `+`,
`*`, and `list` take arbitrary numbers of arguments. One way to
define such procedures is to use `define` with "dotted-tail notation".  
In a procedure definition, a parameter list that has a dot before
the last parameter name indicates that, when the procedure is called, the
initial parameters (if any) will have as values the initial arguments, as
usual, but the final parameter's value will be a `list` of any
remaining arguments.  For instance, given the definition

```
(define (f x y . z) ⟨body⟩)
```

the procedure `f` can be called with two or more arguments.  If we
evaluate

```
(f 1 2 3 4 5 6)
```

then in the body of `f`, `x` will be 1, `y` will be 2, and
`z` will be the list `(3 4 5 6)`.  Given the definition

```
(define (g . w) ⟨body⟩)
```

the procedure `g` can be called with zero or more arguments.  If we
evaluate

```
(g 1 2 3 4 5 6)
```

then in the body of `g`, `w` will be the list `(1 2 3 4 5 6)`.

Note: Dotted-tail notation is similar to the `*args` syntax in Python.  For example:

```
def f(x, y, *z):
    ...
```

Use this notation to write a procedure `same-parity` that takes one or
more integers and returns a list of all the arguments that have the same
even-odd parity as the first argument.  For example,

```
(same-parity 1 2 3 4 5 6 7)
(1 3 5 7)

(same-parity 2 3 4 5 6 7)
(2 4 6)
```
|#


 #|
        (cond
      ((even? (car numeros)) (same-iter (cdr numeros) (cons (car numeros) numeros-parity)))
      (else (same-iter (cdr numeros) (cons (car numeros) numeros-parity))))|#



(define (reverse lista)
  (define (reverse-iter lista lista-rev)
    (if (= (length lista) 0)
        lista-rev
        (reverse-iter (cdr lista) (cons (car lista) lista-rev))
        ))
  (reverse-iter lista null))


(define (same-parity . numeros)
  (define (same-iter numeros numeros-parity parity)
    (if (= (length numeros) 0)
        (reverse numeros-parity)
       (if (parity (car numeros))
        (same-iter (cdr numeros) (cons (car numeros) numeros-parity) parity)
        (same-iter (cdr numeros) numeros-parity parity))     
      )
    )
  (cond
      ((even? (car numeros)) (same-iter numeros null even?))
      (else (same-iter numeros null odd?)  )
   
  )
 )


#|
La función same-parity se encarga de verificar la paridad del primer elemento de la lista llamada numeros y la paridad se pasa como argumento
a una función auxiliar llamada same-iter que es un método iterativo que se encarga de ir añadiendo de la lista numeros a una lista
llamada numeros-parity los elementos
con la misma paridad que el primer elemento de la lista numeros, mientras va reduciendo la lista de numeros eliminando el inicial y añadiendolo si se
cumple con la paridad. Esto se hasta que la lista de numeros queda vacía y es cuando entonces se retorna la lista obtenida y requerida en orden inverso
debido a que mientras se va a añadiendo elementos,este se va a añadiendo al inicio y desplazando los demás, de esta manera obtenemos la lista parecida
a la lista inicial pero en este caso se debe cumplir lo de la paridad.

|#


(same-parity 1 2 3 4 5 6 7)

(same-parity 2 3 4 5 6 7)