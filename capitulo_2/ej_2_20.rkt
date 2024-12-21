#lang racket

;El proceso se puede llamar con dos o mas argumentos
;(define (f x y . z) (+ x (car z)))
;(f 1 2 3 4 5 6)

;El proceso se puede tener entre 0 y n componentes
;(define (g . w) (+ (car w) (car (cdr w))))
;(g 1 2 3 4 5 6)

(define (same-parity x . z)
  (define paridad (modulo x 2)) ;Obtengo el valor de la paridad
  (define (filtro lista)
    (cond
      ((null? lista) '()); Si la lista esta vacia se devuelve la lista vacia
      ((= (modulo (car lista) 2) paridad) ;Compruebo si el primero tiene la mima paridad
       (cons (car lista) (filtro (cdr lista)))) ; Incluir en la lista de resultado
      (else
       (filtro (cdr lista))))) ; Continuar con la cola de la lista
  (cons x (filtro z))) 
      

(same-parity 1 2 3 4 5 6 7)


(same-parity 2 3 4 5 6 7)
