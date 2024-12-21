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
          (else (error "Unknown request: MAKE-ACCOUNT" m))))  
  dispatch) 

; Crea una cuenta con un balance inicial de 50
(define acc (make-account 50))
; Se crea el entorno E1 asociado a la ejecución de make-account. Este entorno contiene: Una variable local balance inicializada con 50 y Los procedimientos
; locales withdraw, deposit, y dispatch.
; El procedimiento dispatch se devuelve como resultado y está vinculado al entorno E1.

#|
  Es decir, tendriamos:
  Global
  |-- acc -> dispatch [en E1]

  E1
  |-- balance: 50
  |-- withdraw: procedimiento (en E1)
  |-- deposit: procedimiento (en E1)
  |-- dispatch: procedimiento (en E1)
|#

((acc 'deposit) 40)  ; Incrementa el balance de `acc` a 90
; El entorno de `acc` "E1" tiene balance = 90

((acc 'withdraw) 60)  ; Decrementa el balance de `acc` a 30
; El entorno de `acc` "E1" tiene balance = 30


; Crea una segunda cuenta con un balance inicial de 100
(define acc2 (make-account 100))
; Se crea un nuevo entorno E2 para make-account, independiente del entorno E1. Este nuevo entorno tiene: Un estado local balance inicializado con 100. Sus
; propios procedimientos withdraw, deposit, y dispatch.

#|
  De manera que al final obtendriamos:
  Global
  |-- acc -> dispatch [en E1]
  |-- acc2 -> dispatch [en E2]

  E1
  |-- balance: 30
  |-- withdraw: procedimiento (en E1)
  |-- deposit: procedimiento (en E1)
  |-- dispatch: procedimiento (en E1)

  E2
  |-- balance: 100
  |-- withdraw: procedimiento (en E2)
  |-- deposit: procedimiento (en E2)
  |-- dispatch: procedimiento (en E2)
|#

; Los procedimientos withdraw, deposit y dispatch son compartidos entre ambas cuentas, pero cada cuenta tiene su entorno local donde se guarda el
; valor de balance.
; Los procedimientos son los mismos (es decir, los mismos procedimientos de código), pero los valores de balance son independientes.
