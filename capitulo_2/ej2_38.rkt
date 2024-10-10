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

; valores
(fold-right / 1 (list 1 2 3))         ; -> 3/2
(fold-left  / 1 (list 1 2 3))         ; -> 1/6
(fold-right list null (list 1 2 3))   ; -> '(1 (2 (3 ())))
(fold-left  list null (list 1 2 3))   ; -> '(((() 1) 2) 3)

; Give a property that op should satisfy to guarantee that fold-right and fold-left will produce the same values for any sequence.
; La propiedad conmutativa: sea * : VxV -> V una aplicación, para todos a,b en V, se tiene que a * b = b * a.
; Por ejemplo, la suma y el producto en R
(fold-right + 0 (list 1 2 3))
(fold-left + 0 (list 1 2 3))
(fold-right * 1 (list 4 3 2))
(fold-left * 1 (list 2 3 4))
