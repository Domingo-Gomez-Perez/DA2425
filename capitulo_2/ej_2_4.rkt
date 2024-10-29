#lang racket

#|
**Exercise 2.4:** Here is an alternative procedural
representation of pairs.  For this representation, verify that `(car (cons x y))`
yields `x` for any objects `x` and `y`.

```
(define (cons x y) 
  (lambda (m) (m x y)))

(define (car z) 
  (z (lambda (p q) p)))
```

What is the corresponding definition of `cdr`? (Hint: To verify that this
works, make use of the substitution model of section 1.1.5)
|#

(define (cons x y) 
  (lambda (m) (m x y)))

(define lista (cons 2 3))

(define (car z) 
  (z (lambda (p q) p)))

(define (cdr z) 
  (z (lambda (p q) q)))

(define (f x y) x)
(define (l x y) y)

((cons 2 3) f)  ;le aplico una funcion car a la lista de 2 elementos
((cons 2 3) l) ;le aplico una funcion cdr a la lista de 2 elementos


(car lista) 

(cdr lista)


#|
Lo que cdr hace, es devolver todos los elementos restantes de la lista excepto el inicial (es lo que devuelve la función car).
Para ello, lo que sucede al llamar a ((cons 2 3) f) y al aplicar el método de substitución es:



((lambda (m) (m 2 3)) f)

(f 1 2)

1

|#