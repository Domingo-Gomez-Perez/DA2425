#lang racket

#|

**Exercise 2.17:** Define a procedure
`last-pair` that returns the list that contains only the last element of a
given (nonempty) list:

```
(last-pair (list 23 72 149 34))
(34)
```
|#


(define (length s)
    (if (null? s)
        0
	(+ 1 (length (cdr s)))))

(define (last-pair lista)
  (if (= (length lista) 1)
      (car lista)
      (last-pair (cdr lista)))
  )

(last-pair (list 23 72 149 34))