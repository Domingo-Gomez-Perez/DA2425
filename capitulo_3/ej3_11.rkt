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

; Entorno Global:
;   make-account -> [Objeto procedimiento con el código de make-account, apuntando al Global]

; Evaluación de (define acc (make-account 50)):

; 1. Se llama a make-account con balance = 50.
; 2. Se crea un nuevo entorno E1:
;    - balance: 50
;    - withdraw -> [Procedimiento, apunta a E1]
;    - deposit -> [Procedimiento, apunta a E1]
;    - dispatch -> [Procedimiento, apunta a E1]
; 3. dispatch es retornado y vinculado a acc en el Entorno Global.

; Resultado:
; Entorno Global:
;   make-account -> [Procedimiento, apunta al Global]
;   acc -> [dispatch, apunta a E1]

; Entorno E1 (creado por (make-account 50)):
;   balance: 50
;   withdraw -> [Procedimiento, apunta a E1]
;   deposit -> [Procedimiento, apunta a E1]
;   dispatch -> [Procedimiento, apunta a E1]

; Evaluación de ((acc 'deposit) 40):

; 1. acc apunta a dispatch, que apunta a E1.
; 2. En E1, se evalúa (dispatch 'deposit), que retorna deposit.
; 3. Se llama a deposit con amount = 40:
;    - balance en E1 se actualiza: balance = (+ balance amount) = 50 + 40 = 90.
; 4. Retorna 90.

; Resultado:
; Entorno Global:
;   make-account -> [Procedimiento, apunta al Global]
;   acc -> [dispatch, apunta a E1]

; Entorno E1 (actualizado):
;   balance: 90
;   withdraw -> [Procedimiento, apunta a E1]
;   deposit -> [Procedimiento, apunta a E1]
;   dispatch -> [Procedimiento, apunta a E1]

; Evaluación de ((acc 'withdraw) 60):

; 1. acc apunta a dispatch, que apunta a E1.
; 2. En E1, se evalúa (dispatch 'withdraw), que retorna withdraw.
; 3. Se llama a withdraw con amount = 60:
;    - En E1, se evalúa (>= balance amount): 90 >= 60, es verdadero.
;    - balance en E1 se actualiza: balance = (- balance amount) = 90 - 60 = 30.
; 4. Retorna 30.

; Resultado:
; Entorno Global:
;   make-account -> [Procedimiento, apunta al Global]
;   acc -> [dispatch, apunta a E1]

; Entorno E1 (actualizado):
;   balance: 30
;   withdraw -> [Procedimiento, apunta a E1]
;   deposit -> [Procedimiento, apunta a E1]
;   dispatch -> [Procedimiento, apunta a E1]

; Evaluación de (define acc2 (make-account 100)):

; 1. Se llama a make-account con balance = 100.
; 2. Se crea un nuevo entorno E2:
;    - balance: 100
;    - withdraw -> [Procedimiento, apunta a E2]
;    - deposit -> [Procedimiento, apunta a E2]
;    - dispatch -> [Procedimiento, apunta a E2]
; 3. dispatch es retornado y vinculado a acc2 en el Entorno Global.

; Resultado:
; Entorno Global:
;   make-account -> [Procedimiento, apunta al Global]
;   acc -> [dispatch, apunta a E1]
;   acc2 -> [dispatch, apunta a E2]

; Entorno E2 (creado por (make-account 100)):
;   balance: 100
;   withdraw -> [Procedimiento, apunta a E2]
;   deposit -> [Procedimiento, apunta a E2]
;   dispatch -> [Procedimiento, apunta a E2]

; Respuestas a las preguntas:

; 1. ¿Dónde se guarda el estado local para acc?
;    El estado local de acc se guarda en el entorno E1, específicamente en la variable balance.

; 2. ¿Cómo se mantienen distintos los estados locales de acc y acc2?
;    Cada llamada a make-account crea un nuevo entorno (E1 para acc y E2 para acc2), y cada entorno tiene su propia variable balance independiente.

; 3. ¿Qué partes del entorno comparten acc y acc2?
;    Ambos comparten el Entorno Global y las definiciones del código de make-account, withdraw, deposit y dispatch. Sin embargo, no comparten los entornos E1 y E2, donde se almacenan sus estados locales.
