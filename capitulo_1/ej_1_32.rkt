#lang racket

#|
**Exercise 1.32:**

1. 

Show that `sum` and `product` are both special
cases of a still more general notion called `accumulate` that combines a
collection of terms, using some general accumulation function:

```
(accumulate combiner null-value term a next b)
```

`Accumulate` takes as arguments the same term and range specifications as
`sum` and `product`, together with a `combiner` procedure (of
two arguments) that specifies how the current term is to be combined with the
accumulation of the preceding terms and a `null-value` that specifies what
base value to use when the terms run out.  Write `accumulate` and show how
`sum` and `product` can both be defined as simple calls to `accumulate`.
|#

(define (next n)
  (+ 1 n))

(define (identity n) n)

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
         (accumulate combiner null-value term (next a) next b)))
  )


(accumulate * 2 identity 1 next 5);entiendo que hace determinada operacion con los numeros precedentes a 5 y ese número lo suma o multiplica (combiner)
                                  ;por el valor de null-value


#|
2. If your `accumulate` procedure generates a recursive process, write one
that generates an iterative process.  If it generates an iterative process,
write one that generates a recursive process.
|#

(define (accumulate-iter combiner null-value term a next b)
(define (accumulate a null-value)
  (if (> a b)
      null-value
         (accumulate (next a) (combiner (term a) null-value)))
  )
  (accumulate a null-value))


(accumulate-iter * 2 identity 1 next 5) 