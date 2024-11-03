#lang racket

; Exercise 2.38

; The procedure `accumulate` is also known as `fold-right`, because it combines
; the first element of the sequence with the result of combining all the elements
; to the right. There is also a `fold-left`, which is similar to `fold-right`,
; except that it combines elements working in the opposite direction:

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


; What are the values of

(fold-right / 1 (list 1 2 3))       ; Should return 3/2
(fold-left  / 1 (list 1 2 3))       ; Should return 1/6
(fold-right list '() (list 1 2 3))  ; Should return '(1 (2 (3 ())))
(fold-left  list '() (list 1 2 3))  ; Should return '(((() 1) 2) 3)


; Give a property that `op` should satisfy to guarantee that
; `fold-right` and `fold-left` will produce the same values for any
; sequence.


; `op` must satisfy the commutative property. For instance:

; Ops which satisfy it...
; 5+4 = 4+5     ->    9  = 9
; 5*4 = 4*5     ->    20 = 20

; Ops which do not satisfy it...
; 4-5 != 5-4    ->    -1  != 1
; 4/5 != 5/4    ->    0.8 != 1.2