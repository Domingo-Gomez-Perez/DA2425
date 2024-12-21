#lang racket
 (define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance 
                        amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: 
                        MAKE-ACCOUNT" 
                       m))))
  dispatch)

(define acc (make-account 50))

((acc 'deposit) 40)


((acc 'withdraw) 60)

(define acc2 (make-account 100))


;Cuando se ejecuta el método make-account se crea ambiente enlazado al ambiente global y dando un  valor argumento.
;En esre caso se introducen al ambiente 3 dunciones: dispatch, deposit y withdraw. Esto sucede en las dos llamada de make-account.

;Al evaluar ((acc 'deposit)40) se llama a la función dispatch con m = 'deposit y devuelve la función deposit llamada con amount 40.
;Cuando  se ejecuta ((acc 'withdraw) 60) se llama a la funciñon dispatch con m = 'withdrawn y decuelve la función withdrawn con 60 de valor argumento.




