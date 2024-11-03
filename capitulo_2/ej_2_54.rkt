#lang racket

#|
**Exercise 2.54:** Two lists are said to be
`equal?` if they contain equal elements arranged in the same order.  For
example,

```
(equal? '(this is a list) 
        '(this is a list))
```

is true, but

```
(equal? '(this is a list) 
        '(this (is a) list))
```

is false.  To be more precise, we can define `equal?`  recursively in
terms of the basic `eq?` equality of symbols by saying that `a` and
`b` are `equal?` if they are both symbols and the symbols are
`eq?`, or if they are both lists such that `(car a)` is `equal?`
to `(car b)` and `(cdr a)` is `equal?` to `(cdr b)`.  Using
this idea, implement `equal?` as a procedure. (Note: This implementation
is only concerned with lists of symbols).

Note: In practice,
programmers use `equal?` to compare lists that contain numbers as well as
symbols.  Numbers are not considered to be symbols.  The question of whether
two numerically equal numbers (as tested by `=`) are also `eq?` is
highly implementation-dependent.  A better definition of `equal?` (such as
the one that comes as a primitive in Scheme) would also stipulate that if
`a` and `b` are both numbers, then `a` and `b` are
`equal?` if they are numerically equal.  Can you modify `(equal?)` to also
work with numbers?


|#


(define (equal2? lista1 lista2)
  (cond
    ;comprueba si ambas listas están vacías
    ((and (null? lista1) (null? lista2)) #t)
    
    ;comprueba si una lista está vacía y la otra no
    ((or (null? lista1) (null? lista2)) #f)
    
    ; comprueba si ambos elementos son listas, llama a equal2? recursivamente
    ((and (list? (car lista1)) (list? (car lista2)))
     (if (equal2? (car lista1) (car lista2))
         (equal2? (cdr lista1) (cdr lista2))
         #f))

    ;verifica si ambos elementos son iguales
    ((equal? (car lista1) (car lista2))
     (equal2? (cdr lista1) (cdr lista2)))

    ; si los elementos diferentes
    (else #f)))


(equal2? '(this  is a list) 
        '(this is a list))

(equal2? '(123(5(4 76)8)) 
        '(123(5 4(76)8)))


(equal? '(this is a list) 
        '(this is a list))

(equal2? '(this is a list) 
        '(this (is a) list))

