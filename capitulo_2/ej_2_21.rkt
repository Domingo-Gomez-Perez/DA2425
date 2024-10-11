#lang racket

#|

**Exercise 2.21**: The procedure `square-list`
takes a list of numbers as argument and returns a list of the squares of those
numbers.

```
(square-list (list 1 2 3 4))
(1 4 9 16)
```

Here are two different definitions of `square-list`.  Complete both of
them by filling in the missing expressions:

```
(define (square-list items)
  (if (null? items)
      nil
      (cons ⟨??⟩ ⟨??⟩)))

(define (square-list items)
  (map ⟨??⟩ ⟨??⟩))
```
|#

#|Apartado a|#

(define (square-list items)
  (if (null? items)
      null
      (cons (sqr(car items)) (square-list (cdr items)))
  )
)

(square-list (list 1 2 3 4))

#|Apartado b|#
(define (square2-list items)
  (map sqr items))

(square2-list (list 1 2 3 4))

