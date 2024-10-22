#lang racket
;Exercise 2.17: Define a procedure last-pair that returns the list that contains only the last element of a given (nonempty) list:

;(last-pair (list 23 72 149 34))
;(34)

(define (even x) (= (remainder x 2) 0))

(define (long lista) (if (null? lista) (- 1 1) (+ (long (cdr lista)) 1)))

(define (last-pair-aux lista ultpar) (if (> (long lista) 0)
                                      (if (even (car lista)) (last-pair-aux (cdr lista) (car lista)) (last-pair-aux (cdr lista) ultpar))
                                      ultpar
                                      )
  )

(define (last-pair lista) (last-pair-aux lista 0))

(last-pair (list 23 72 149 34))
;Efectivamente da 34