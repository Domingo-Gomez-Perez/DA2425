#lang racket

; **Exercise 2.22**: Louis Reasoner tries to rewrite
; the first `square-list` procedure of Exercise 2.21 so that it
; evolves an iterative process:

; ```
; (define (square-list items)
;   (define (iter things answer)
;     (if (null? things)
;         answer
;         (iter (cdr things)
;               (cons (square (car things))
;                     answer))))
;   (iter items nil))
; ```

; Unfortunately, defining `square-list` this way produces the answer list in
; the reverse order of the one desired.  Why?

;RESPUESTA: Se está dando la lista en el orden contrario porque el 
;   proceso de construcción de la lista
;   usa la función cons, que añade los nuevos elementos al inicio de la lista acumulada answer. 
; En cada iteración, el resultado parcial (answer) 
;   tiene los elementos cuadrados, pero los está agregando al frente, 
;    lo que invierte el orden natural de los elementos.


; Louis then tries to fix his bug by interchanging the arguments to `cons`:

; ```
; (define (square-list items)
;   (define (iter things answer)
;     (if (null? things)
;         answer
;         (iter (cdr things)
;               (cons answer
;                     (square 
;                      (car things))))))
;   (iter items nil))
; ```

; This doesn't work either.  Explain.

;RESPUESTA: Este enfoque tampoco funciona correctamente porque ahora la expresión cons 
;   está construyendo pares anidados, no una lista plana. En lugar de agregar el cuadrado 
;   del elemento actual a la lista acumulada, 
;   lo está combinando incorrectamente con answer como el primer argumento de cons.


;Implementación correcta: 

(define (map proc lst)
  (cond
    [(null? lst) '()]  ;; Si la lista está vacía, devolvemos la lista vacía.
    [else (cons (proc (car lst)) (map proc (cdr lst)))]))  ;; Aplicamos la función y continuamos recursivamente.

;Caso de ejemplo:
(display "Aplicar la función cuadrado a (list 1 2 3 4): ")
(display (map (lambda (x) (* x x)) (list 1 2 3 4)))  ;; Debería mostrar (1 4 9 16)
(newline)