#lang racket


(define (equal? a b)
  (cond 
    ;; Ambas listas vacías son iguales
    ((and (null? a) (null? b)) true)
    
    ;; Si una lista está vacía y la otra no, son diferentes
    ((or (null? a) (null? b)) false)
    
    ;; Si ambas son listas, comparamos car y cdr
    ((and (list? a) (list? b))
     (and (equal? (car a) (car b))  ; Compara las cabeceras
          (equal? (cdr a) (cdr b)))  ; Compara las colas
     )
    
    ;; Si ambas son símbolos, usamos eq?
    ((and (symbol? a) (symbol? b))
     (eq? a b))

    ;; Para otros tipos, usamos equal?
    (else (equal? a b)))) 





(equal? '(this is a list) 
        '(this (is a) list))