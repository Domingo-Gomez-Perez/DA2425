#lang racket
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op 
                      initial 
                      (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(fold-right / 1 (list 1 2 3)) ;-> (/ 1 (/ 2 (/ 3 1))) = 1 / (/ 2 (/ 3 1)) = 1 / (2 / (/ 3 1)) =
                                ; = 1 / (2 / (3 / 1)) = 1 / (2 / 3) = 3 / 2

(fold-left  / 1 (list 1 2 3)) ;-> (/ (/ (/ 1 3) 2) 1) = (/ (/ (1 / 3) 2) 1) = (/ ((1 / 3) / 2) 1) =
                                ; = (((1 / 3) / 2) / 1) = 1 / (3*2*1) = 1 / 6

(fold-right list null (list 1 2 3)) ;-> (1 (2 (3 ())))
(fold-left  list null (list 1 2 3)) ;-> (((() 1) 2) 3)

;La propiedad que se ha de cumplir es la de la conmutatividad.