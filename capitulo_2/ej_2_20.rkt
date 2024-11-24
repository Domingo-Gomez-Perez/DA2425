#lang racket
;Ejercicio 2.20

(define (same-parity x . lista)
  (define (check-parity list)
    (if (null? list)
        '()  
        (let ((y (car list)))
          (if (= (modulo y 2) (modulo x 2)) 
              (cons y (check-parity (cdr list))) 
              (check-parity (cdr list)))))) 
  (cons x (check-parity lista))) 

(same-parity 1 2 3 4 5 6 7)


(same-parity 2 3 4 5 6 7)
