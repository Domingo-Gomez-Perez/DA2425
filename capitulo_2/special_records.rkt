#lang racket
(define (assoc key record)
  (if (null? record)
      null
      (if (eq? key (car (car record)))
          (car record)
          (assoc key (cdr record)))))

(define (add-entry key value record)
  (if (null? record)
      (list (list key value))
      (let ((entry (car record)))
        (if (eq? key (car entry))
            (cons (list key value) (cdr record))
            (cons entry (add-entry key value (cdr record)))))))

(define (del-entry key record)
  (if (null? record)
      null
      (let ((entry (car record)))
        (if (eq? key (car entry))
            (cdr record)
            (cons entry (del-entry key (cdr record)))))))

(define record '((x 1) (y 2) (z 3)))
(assoc 'y record)      ; -> (y 2)
(add-entry 'w 4 record)  ; -> ((x 1) (y 2) (z 3) (w 4))
(add-entry 'x 10 record) ; -> ((x 10) (y 2) (z 3))
(del-entry 'x record)   ; -> ((y 2) (z 3))
