#lang racket

; **Exercise 2.38:**  The procedure `accumulate` is also known as `fold-right`, because it combines the first element of
; the sequence with the result of combining all the elements to the right.  There
; is also a `fold-left`, which is similar to `fold-right`, except that
; it combines elements working in the opposite direction:

; ```
; (define (fold-left op initial sequence)
;   (define (iter result rest)
;     (if (null? rest)
;         result
;         (iter (op result (car rest))
;               (cdr rest))))
;   (iter initial sequence))
; ```

; What are the values of

; ```
; (fold-right / 1 (list 1 2 3))
; (fold-left  / 1 (list 1 2 3))
; (fold-right list nil (list 1 2 3))
; (fold-left  list nil (list 1 2 3))
; ```

; Give a property that `op` should satisfy to guarantee that
; `fold-right` and `fold-left` will produce the same values for any
; sequence.

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) (fold-right op initial (cdr sequence)))))


(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

  

(fold-right / 1 (list 1 2 3)); Resultado = 3/2
(fold-left  / 1 (list 1 2 3)); Resultado = 1/6
(fold-right list null (list 1 2 3)); Resultado = '(1 (2 (3 ( ))))
(fold-left  list null (list 1 2 3)); Resultado = '(((() 1) 2) 3)


(fold-right + 0 (list 1 2 3)) ; Esto devolverá 6 ;(1 + 2 + 3)
(fold-right list '() (list 1 2 3)) ; Esto devolverá (1 2 3)

;Para que fold-right y fold-left produzcan el mismo resultado,
; la operación op debe ser asociativa. Una operación es asociativa si el orden
; en que se agrupan los operandos no afecta al resultado.
;Por ejemplo, la suma (+) y la multiplicación (*) son operaciones asociativas:

(fold-right + 3 (list 4 2 3)) ; Esto devolverá 12 ; LO HACE VVV
(fold-left + 3 (list 4 2 3)) ; Esto devolverá 12 ; LO HACE VVV