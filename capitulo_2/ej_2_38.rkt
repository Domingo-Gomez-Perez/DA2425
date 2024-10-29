#lang racket

#|
**Exercise 2.38:**  The procedure `accumulate` is also known as `fold-right`, because it combines the first element of
the sequence with the result of combining all the elements to the right.  There
is also a `fold-left`, which is similar to `fold-right`, except that
it combines elements working in the opposite direction:

```
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))
```

What are the values of

```
(fold-right / 1 (list 1 2 3))
(fold-left  / 1 (list 1 2 3))
(fold-right list nil (list 1 2 3))
(fold-left  list nil (list 1 2 3))
```

Give a property that `op` should satisfy to guarantee that
`fold-right` and `fold-left` will produce the same values for any
sequence.
|#



(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(define (fold-right op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op (car rest) result)
              (cdr rest))))
  (iter initial (reverse sequence)))


(fold-right / 1 (list 1 2 3))

#|
(fold-right op initial sequence)
(fold-right / 1 (list 1 2 3))
 
 (iter result rest)
 (iter initial (reverse sequence))
 (iter 1 (list 3 2 1))
 (if (null? rest)
        result
        (iter (op (car rest) result)
              (cdr rest)))
 (iter (op (car rest) result)
              (cdr rest))
 (iter (/ 3 1) (2 1))
 (iter (/ 2 3) (1))
 (iter (/ 1 (/ 2 3)))
 (1 / (2/3)
 3/2


|#
(fold-left  / 1 (list 1 2 3))

#|
(fold-left op initial sequence)
(fold-left / 1 (list 1 2 3))
 
 (iter result rest)
 (iter initial (reverse sequence))
 (iter 1 (list 3 2 1))
 (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest)))
 (iter (op result (car rest))
              (cdr rest))
 (iter (/ 1 1) (2 3))
 (iter (/ 1 2) (3))
 (iter (/ (/ 1 2) 3))
 ((1 / 2) / 3)

  1/6
|#

(fold-right list null (list 1 2 3))


#|

(fold-right op initial sequence)
(fold-right list null (list 1 2 3))
 
 (iter result rest)
 (iter initial (reverse sequence))
 (iter null (list 3 2 1))
 (if (null? rest)
        result
        (iter (op (car rest) result)
              (cdr rest)))
 (iter (list (car rest) result)
              (cdr rest))

 (iter (list 3 null) (2 1) )
 (iter (list 2 (list 3 null)) 1)
 (iter (list 1(list 2 (list 3 null)))
 (1(2(3 ())))



|#


(fold-left  list null (list 1 2 3))


#|
(fold-left op initial sequence)
(fold-left list null (list 1 2 3))
 
 (iter result rest)
 (iter initial (reverse sequence))
 (iter null (list 1 2 3))
 (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest)))
 (iter (op result (car rest))
              (cdr rest))
 
 (iter (list null 1) (2 3) )
 (iter (list (list null 1) 2) (3))
 (iter (list (list (list null 1) 2) 3))

 ( ( (() 1) 2) 3)


|#


#|
Give a property that `op` should satisfy to guarantee that
`fold-right` and `fold-left` will produce the same values for any
sequence:

Para que las funciones `fold-right` y `fold-left` produzcan el mismo resultado para cualquier secuencia,
se debe aplicar operaciones asociativas como la suma y la multiplicación porque no importa empezar operando desde la izquierda
que empezar desde la derecha, cualquier agrupación va a dar el mismo resultado


|#

;Examples:

(fold-left  + 1 (list 1 2 3))
(fold-right  + 1 (list 1 2 3))

(fold-left  * 1 (list 1 2 3))
(fold-right  * 1 (list 1 2 3))
