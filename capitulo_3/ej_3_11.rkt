#lang racket
;Ejercicio 3.11

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

;Se pide
;mostrar el diagrama de ambientes despues de ejecutar el siguiente codigo:

(define acc (make-account 50))

;env glob --> codigo
;env 1 --> codigo | balance = 50
;                   withdraw->codigo+env
;                   dispatch->codigo+env
;                   deposit->codigo+env

((acc 'deposit) 40)

;env glob --> codigo
;env 1 --> codigo | balance = 90
;                   withdraw->codigo+env
;                   dispatch->codigo+env
;                   deposit->codigo+env --> amount: 40

((acc 'withdraw) 60)
;env glob --> codigo
;env 1 --> codigo | balance = 30
;                   withdraw->codigo+env --> amount: 60
;                   dispatch->codigo+env
;                   deposit->codigo+env --> amount: 40


;Donde se mantiene el estado de acc?
;Que partes tienen en comun si (define acc2 (make-account 100))?

(define acc2 (make-account 100))

;Solucion:

;Cuando se ejecuta el metodo make-account se crea un nuevo ambiente que esta enlazado
;al ambiente global y dando un valor al argumento.

;En este caso, se introducen al ambiente tres funciones: dispacht, deposit, withdraw

;Al evaluar ((acc 'deposit) 40), se llama a la función dispacht con m = 'deposit y
;devuelve la función deposit, esta es llamada con amount = 40