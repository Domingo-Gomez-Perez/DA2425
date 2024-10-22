#lang racket 

; **Exercise 2.39:** Complete the following
; definitions of `reverse` (Exercise 2.18) in terms of
; `fold-right` and `fold-left` from Exercise 2.38.

; ```
; (define (reverse sequence)
;   (fold-right 
;    (lambda (x y) ⟨??⟩) nil sequence))

; (define (reverse sequence)
;   (fold-left 
;    (lambda (x y) ⟨??⟩) nil sequence))
; ```

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



(define (reverse sequence)
  (fold-right 
   (lambda (x y) (cons x y)) ; Agrega x al frente de la lista y
   null
   sequence))

(define (reverse2 sequence)
  (fold-left 
   (lambda (x y) (cons y x)) ; Agrega y al frente de la lista x
   null 
   sequence))

(reverse (list 1 2 3 4)) ; Devolverá (1 2 3 4)

(reverse2 (list 1 2 3 4)) ; Devolverá (4 3 2 1)





