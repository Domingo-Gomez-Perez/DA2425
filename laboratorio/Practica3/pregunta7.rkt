#lang racket 

; Fase de preprocesado dee los datos iniciales
(define (preprocesa lista)
    (sort lista < #:key car))

; Pre: la lista se asume ordenada en orden no decreciente
(define (divide-lista lista)
    (define mid (/ (length lista) 2))
    (let loop ((i 0) (p1 (list)) (p2 (list)))
        (if (= i (length lista))
            (list p1 p2)
            (begin
                (if (< i mid)
                    (loop (+ i 1) (append p1 (list (list-ref lista i))) p2)
                    (loop (+ i 1) p1 (append p2 (list (list-ref lista i)))))))))

(define lista (list (list 1 4) (list 3 3) (list 4 8) (list 3 0) (list 3 20) (list 0 7) (list 3 2)))
(define ordenada (preprocesa lista))
(define parts (divide-lista ordenada))
(define p1 (car parts))
(define p2 (cadr parts))

(displayln (list "P1: " p1))
(displayln (list "P2: " p2))
