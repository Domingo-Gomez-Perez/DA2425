#lang racket

#|
**Exercise 2.18:** Define a procedure `reverse`
that takes a list as argument and returns a list of the same elements in
reverse order:

```
(reverse (list 1 4 9 16 25))
(25 16 9 4 1)
```
Bonus: Can you design an algorithm that requires only n steps for a list containing
n items?

|#

(define (length s)
    (if (null? s)
        0
	(+ 1 (length (cdr s)))))



(define (reverse lista)
  (define (reverse-iter lista lista-rev)
    (if (= (length lista) 0)
        lista-rev
        (reverse-iter (cdr lista) (cons (car lista) lista-rev))
        ))
  (reverse-iter lista null))

(reverse (list 1 4 9 16 25))

(reverse (list 1 2 3(list 1 4 9 16)25))

