#lang racket
 (define (deep-reverse lista)
   (define (rev-iter lista resultado)
    (if (= (length lista) 0)
     resultado
     (rev-iter (cdr lista)
               (cons (if (list? (car lista))
                                (deep-reverse (car lista))
                                (car lista))
                                resultado)))
     )
   (rev-iter lista null)
   )

(define x (list (list 1 2) (list 3 4)))

(deep-reverse x)
