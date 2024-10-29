#lang racket


#|


**Exercise 2.28:** Write a procedure `fringe`
that takes as argument a tree (represented as a list) and returns a list whose
elements are all the leaves of the tree arranged in left-to-right order.  For
example,

```
(define x 
  (list (list 1 2) (list 3 4)))

(fringe x)
(1 2 3 4)

(fringe (list x x))
(1 2 3 4 1 2 3 4)
```
|#

(define x 
  (list (list 1 2) (list 3 4)))


(define (length s)
    (if (null? s)
        0
	(+ 1 (length (cdr s)))))



(define (fringe lista)
  (define (fringe-iter lista lista-rev)
    (cond ((null? lista)
        lista-rev)
        
        (else
         (fringe-iter (cdr lista)
                           
                           (if (list? (car lista))
                                                  (fringe-iter (car lista) lista-rev)
                                                
                                                 (append lista-rev (list (car lista))) )
                                                  )
        )
        ))
  
  (fringe-iter lista null))
              

;ejemplos de uso
(fringe (list 1 2 3(list 1 (list 5 11(list 3 0) 17)4 9 16) 13 25))

(fringe x)

(fringe (list x x))