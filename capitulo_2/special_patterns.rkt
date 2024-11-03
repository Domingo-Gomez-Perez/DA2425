#lang racket
(define (match pattern data)
  (cond
    ;; Caso base: si ambos son iguales, coinciden
    ((equal? pattern data) #t)
    
    ;; Si el patrón es una lista, ambos deben ser listas
    ((and (list? pattern) (list? data))
     (match-list pattern data))
    
    ;; Si el patrón es un símbolo "?", acepta cualquier valor
    ((symbol? pattern) 
     (if (string-prefix? "?" (symbol->string pattern))
         #t
         #f))
    
    ;; En cualquier otro caso, no coinciden
    (else #f)))

;; Función auxiliar para comparar listas
(define (match-list pattern-list data-list)
  (cond
    ;; Si ambas listas son nulas, coinciden
    ((and (null? pattern-list) (null? data-list)) #t)
    
    ;; Si una lista es nula y la otra no, no coinciden
    ((or (null? pattern-list) (null? data-list)) #f)
    
    ;; Comparamos el primer elemento de cada lista y continuamos con los siguientes
    (else
     (and (match (car pattern-list) (car data-list))
          (match-list (cdr pattern-list) (cdr data-list))))))


(define record '(job (Hacker Alyssa P) (computer programmer)))
(match '(job ? ?) record)           ; --> true
(match '(job ? (? coder)) record)   ; --> false
(match '(? ? (computer ?)) record)  ; --> true