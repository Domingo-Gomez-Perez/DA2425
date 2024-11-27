#lang racket


; **Exercise 3.11:** Will discuss as a group.  In 3.2.3 we saw how
; the environment model described the behavior of procedures with local state.
; Now we have seen how internal definitions work.  A typical message-passing
; procedure contains both of these aspects.  Consider the bank account procedure
; of 3.1.1:

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin 
          (set! balance (- balance amount))
          balance)
        "Insufficient funds"))
  (define (deposit amount)
    (begin
      (set! balance (+ balance amount))
      balance))
  (define (dispatch m)
    (cond 
      ((eq? m 'withdraw) withdraw)
      ((eq? m 'deposit) deposit)
      (else 
       (error "Unknown request: MAKE-ACCOUNT" m))))
  dispatch)



; Se pide mostrar el diagrama de ambientes después de ejecutar el siguiente código.

(define acc (make-account 50))

((acc 'deposit) 40)
((acc 'deposit) 40)
((acc 'deposit) 40)
((acc 'deposit) 40)
((acc 'deposit) 40)
;90

((acc 'withdraw) 60)
;190

; Donde se mantiene el estado de acc? Qué partes tienen en común si (define acc2 (make-account 100))?

(define acc2 (make-account 100))
; 100

((acc 'withdraw) 60)
; 130

((acc2 'withdraw) 60)
; 40
  
((acc 'deposit) 40)
; 70
  
((acc2 'deposit) 40)
; 80



;TODO: Implementar el diagrama de ambientes (hecho en OneNote).