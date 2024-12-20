#lang racket

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op 
                      initial 
                      (cdr sequence)))))

(fold-right / 1 (list 1 2 3)) ; el valor es 3/2
(fold-left  / 1 (list 1 2 3)) ; el valor es 1/6
(fold-right list '() (list 1 2 3)) ; el valor es (1 (2 (3 ())))
(fold-left  list '() (list 1 2 3)) ; el valor es (((() 1) 2) 3)

;Una op que vaya a dar el mismo valor para las dos sería la suma
(fold-right + 1 (list 1 2 3))
(fold-left  + 1 (list 1 2 3))
