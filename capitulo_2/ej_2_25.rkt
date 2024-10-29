#lang racket

#|

**Exercise 2.25:** Give combinations of `car`s
and `cdr`s that will pick 7 from each of the following lists:

```
(1 3 (5 7) 9)
((7))
(1 (2 (3 (4 (5 (6 7))))))
```
|#


(define lista1 (list 1 3 (list 5 7) 9))
(define lista2 (list(list 7)))
(define lista3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

(display lista1)
(newline)
(display lista2)
(newline)
(display lista3)
(newline)

(newline)

(display "Lista1" )
(newline)
;Lista1
(car(cdr(car(car(list(cdr(cdr lista1)))))))


(display "Lista2" )
(newline)
;Lista2
(car (car lista2))

(display "Lista3" )
(newline)
;Lista3

 (car(cdr(car(cdr(car(cdr(car(cdr(car(cdr(car(car(list(cdr lista3))))))))))))))
