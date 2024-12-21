#lang racket

(define (assoc key record)
  (cond ((null? record)  (null))
        ((eq? key (caar record))  (car record))
        (else (assoc key (cdr record)))
        )
  )

(define r '((x 1) (y 2) (z 3)))

(assoc 'y r)      ; -> (y 2)

(define (add-entry key value record)
  (if (null? key)
      (cond ((null? record)  null)
            (else  (cons (car record) (add-entry key value (cdr record)))))
      (cond ((null? record)  (cons (list key value) null))
            ((eq? key (caar record)) (cons (list key value) (add-entry null value (cdr record))))
            (else  (cons (car record) (add-entry key value (cdr record))))
            )))

;(add-entry 'w 4 r)  ; -> ((x 1) (y 2) (z 3) (w 4))
(add-entry 'x 10 r) ; -> ((x 10) (y 2) (z 3))

(define (del-entry key record)
  (if (null? key)
      (cond ((null? record)  null)
            (else  (cons (car record) (del-entry key (cdr record)))))
      (cond ((null? record)  null)
            ((eq? key (caar record)) (del-entry null (cdr record)))
            (else  (cons (car record) (del-entry key (cdr record))))
            )))

(del-entry `x r)   ; -> ((y 2) (z 3))
(del-entry `z r)   ; -> ((x 1) (y 2))