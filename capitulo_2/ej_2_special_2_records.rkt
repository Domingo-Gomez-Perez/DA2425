#lang racket

; Special Exercise (Records)

; In many programming languages, it is common to represent records as key-value
; pairs (sometimes known as a mapping). For example, you might write:

(define record '((x 1) (y 2) (z 3)))


; Write a procedure `(assoc key record)` that finds the entry with a given key:

(define (assoc key record)
  (cond
    ((null? record) null)
    ((eq? (car (car record)) key) (car record))
    (else (assoc key (cdr record)))))

(assoc 'x record) ; Should return (x 1)
(assoc 'y record) ; Should return (y 2)
(assoc 'a record) ; Should return '()



; Write a procedure `(add-entry key value record)` that adds or replaces an entry 
; (returning a new record as a result).

(define (add-entry key value record)
    (cond
      ((null? record) (list key value))
      ((eq? (car (car record)) key) (add-entry key value (cdr record)))
      (else (append (list (car record)) (list (add-entry key value (cdr record)))))))
  
(add-entry 'w 4 record)  ; Should return ((x 1) (y 2) (z 3) (w 4))
(add-entry 'x 10 record) ; Should return ((x 10) (y 2) (z 3))



; Write a procedure `(del-entry key record)` that deletes an entry 
; (returning a new record).

(define (del-entry key record)
    (cond
      ((null? (cdr record)) (car record))
      ((eq? (car (car record)) key) (del-entry key (cdr record)))
      (else (append (list (car record)) (list (del-entry key (cdr record)))))))

(del-entry 'b record) ; Should return ((x 1) (y 2) (z 3))
(del-entry 'x record) ; Should return ((y 2) (z 3))