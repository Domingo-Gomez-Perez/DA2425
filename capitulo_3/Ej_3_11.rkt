#lang racket
; Ejercicio 3.11

; Primer apartado
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

(define acc (make-account 50)) ; env --> {"balance":50}

((acc 'deposit) 40) ; env --> {"balance":50, "amount":40} --> {"balance":90}
90

((acc 'withdraw) 60) ; env --> {"balance":90, "amount":60} --> {"balance":30}
30

; Segundo apartado

(define acc2 (make-account 100))

; El estado local para acc está en global. Cuando en el código hacemos un define, en el ambiente global
; se guarda una nueva varibale asignada a un nuevo ambiente. Por ello, acc está en global, asignado a su
; tabla hash.

; Dado que acc está en el ambiente global y asignado, no solo a su código, sino también a su ambiente o
; tabla hash. De la misma forma, acc2 se encuentra en el ambiente global, con su propio ambiente o
; o tabla hash. Ambos ambientes están separados y por lo tanto solo se comparte el código.