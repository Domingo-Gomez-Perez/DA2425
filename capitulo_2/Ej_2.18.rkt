#lang racket
 (define (reverse lista)
   (define (rev-iter lista resultado)
    (if (= (length lista) 0)
     resultado
     (rev-iter (cdr lista) (cons (car lista) resultado)))
     )
   (rev-iter lista null)
   )

(reverse '(1 2 3))

