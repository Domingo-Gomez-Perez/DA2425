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


;El entorno global es make-account

(define acc (make-account 50))
;Cuando se llama a (define acc (make-account 50)) se crea un entorno E1 en que:
;- Balance = 50
;y además se definen las funciones withdraw, deposit y dispatch en el entorno E1
;- withdraw: [Procedimiento]
;- deposit: [Procedimiento] 
;- dispatch; [Procedimiento]
; el dispatch se retorna y se vincula a acc en el Entorno Global

((acc 'deposit) 40)
; El ambiente al llamar a ((acc 'deposit) 40)
; Cambia el ambiente al que apunta acc, E1
; En E1, se evalúa (dispatch 'deposit), que retorna deposit.
; Se llama a deposit con amount = 40:
; HAce que se cambie el balance a 90

((acc 'withdraw) 60)  
; El entorno de `acc` "E1" tiene balance = 30
; Hace como el caso anterior pero con withdraw:
; En E1, se evalúa (dispatch 'withdraw), que retorna withdraw.
; Se llama a withdraw con amount = 60;
; Hace que se cambie el balance a 30

; Crea una segunda cuenta con un balance inicial de 100
(define acc2 (make-account 100))
; Se crea un nuevo entorno E2 para make-account, independiente del entorno E1.
; Este nuevo entorno tiene: Un estado local balance inicializado con 100. Sus
; propios procedimientos withdraw, deposit, y dispatch.

#|
  ;;Al crear otra cuenta solo se comparte el ambiente global, cada una tiene su propio ambiente individual por ejemplo
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
