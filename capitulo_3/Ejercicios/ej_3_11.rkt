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

; Cuando se ejecuta este método se crea un nuevo ambiente que está enlazado al ambiente global y dando un valor al argumento
; En este caso se introduce al ambiente 3 funciones (dispatch, deposit y withdraw)

((acc 'deposit) 40)

; Se crea el ambiente en dispacht creando una variable m de valor 'deposit que se enacarga de generar el ambiente de deposit haciendo que la variable amount valga 40
; Posteriormente se borrar los ambientes de dispach y deposit y se modifica la variable del ambiente de make-account

((acc 'withdraw) 60)

; Se crea el ambiente en dispacht creando una variable m de valor 'withdraw que se enacarga de generar el ambiente de withdraw haciendo que la variable amount valga 40
; Posteriormente se borrar los ambientes de dispach y withdraw y se modifica la variable del ambiente de make-account


(define acc2 (make-account 100))

; Se crea otro ambiente con otra variable balance del ambiente, el codigo se mantiene y las demás del ambiente son iguales en contenido pero son distintas porque apuntan a otro código.