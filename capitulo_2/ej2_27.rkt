#lang racket

;; Definimos la función reverse
(define (reverse list)
  (define (a list1 list2)
    (if (null? list1)
        list2
        (a (cdr list1) (cons (car list1) list2))))
  (a list '()))

;; Definimos la función deep-reverse
(define (deep-reverse list)
  (define (a list1 list2)
   (cond ((null? list1)
          list2)
         ((pair? (car list1))
          (a (cdr list1) (cons (deep-reverse (car list1)) list2)))
         (else
          (a (cdr list1) (cons (car list1) list2)))))
  (a list '()))
;; Ejemplo de uso
(define x (list (list 1 2) (list 3 4)))

;; Ver el resultado de deep-reverse
(display "Resultado de deep-reverse: ")
(display (deep-reverse x))
(newline)