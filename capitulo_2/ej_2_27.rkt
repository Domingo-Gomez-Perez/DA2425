#lang racket


#|

**Exercise 2.27:** Modify your `reverse`
procedure of Exercise 2.18 to produce a `deep-reverse` procedure
that takes a list as argument and returns as its value the list with its
elements reversed and with all sublists deep-reversed as well.  For example,

```
(define x 
  (list (list 1 2) (list 3 4)))

x
((1 2) (3 4))

(reverse x)
((3 4) (1 2))

(deep-reverse x)
((4 3) (2 1))
```
|#


(define x 
  (list (list 1 2) (list 3 4)))

(define y
  (list 2 6(list 1 2) (list 3 4)))


(define (length s)
    (if (null? s)
        0
	(+ 1 (length (cdr s)))))

(define (last-pair lista)
  (if (= (length lista) 1)
      (car lista)
      (last-pair (cdr lista)))
  )


(define (deep-reverse lista)
  (define (deep-reverse-iter lista lista-rev)
    (if (null? lista)
        (map reverse lista-rev)
        (deep-reverse-iter (cdr lista) (cons (car lista) lista-rev))
        ))
  (deep-reverse-iter lista null))

(display x)
(newline)
(display y)
(newline)
(deep-reverse x)
(reverse y)
;(deep-reverse y)

