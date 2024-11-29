#lang racket

(define (reverse lst)
  (if (null? lst)
      '()                     ; Si la lista esta vacia retorna la lista vacia
      (append (reverse (cdr lst)) (list (car lst))) ; Da la vuelta a la lista recursivamente 
  ))

; reverse con complejidad 0(n)
(define (reverse2 lst result)
  (if (null? lst)
      result                     ; Si la lista esta vacia retorna la lista vacia
      (append (reverse (cdr lst)) (cons (car lst) result)) ; Da la vuelta a la lista recursivamente 
  ))

(define (deep-reverse lst)
  (if (null? lst)
      '()  ; Si la lista está vacía, devuelve la lista vacía
      (append (deep-reverse (cdr lst)) 
              (list (if (list? (car lst))
                        (deep-reverse (car lst))  ; Si el elemento es una lista, lo invierte recursivamente
                        (car lst))))))

; Extra (hacerlo complejidad 0(n))
(define (deep-reverse2 lst result)
  (if (null? lst)
      result  ; Si la lista está vacía, devuelve la lista vacía
      (append (deep-reverse (cdr lst)) 
              (if (list? (car lst))
                        (deep-reverse (cons (car lst) result))  ; Si el elemento es una lista, lo invierte recursivamente
                        (cons (car lst) result)))))

; Ejemplos:

(define lista1 (list 1 (list 3 5 6) 7 9 (list 10 11 13)))

lista1 ; Lista base: (1 (3 5 6) 7 9 (10 11 13))

(reverse lista1) ; Deberia devolver la lista invertida excepto las listas internas, es decir: ((10 11 13) 9 7 (3 5 6) 1)

(deep-reverse lista1) ; Deberia devolver la lista invertida incluyendo las listas internas, es decir: ((13 11 10) 9 7 (6 5 3) 1)

(deep-reverse2 lista1 (list)) ; Deberia devolver la lista invertida incluyendo las listas internas, es decir: ((13 11 10) 9 7 (6 5 3) 1)