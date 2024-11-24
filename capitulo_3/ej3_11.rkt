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

;Se pide mostrar el diagrama de ambientes despues de ejecutar el siguiente codigo:

(define acc (make-account 50))

((acc 'deposit) 40)

((acc 'withdraw) 60)

;Donde se mantiene el estado de acc?
;Que partes tienen en comun si(define acc2 (make-account 100)) ?

(define acc2 (make-account 100))

;SOLUCION:

;Cuando se ejecuta el método se crea un nuevo ambinte que esta enlazado al ambiente
;global  y dando un valor al argumento.
;En este caso, se introducen al ambiente tres funciones:
;dispatch, deposit, withdrawn.

;Al evaluar ((acc ‘deposit) 40), se llama a la función dispatch con m = ‘deposit
;y devuelve la función deposit, esta es llama con amount = 40





