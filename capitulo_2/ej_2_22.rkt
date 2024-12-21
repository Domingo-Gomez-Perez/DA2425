#lang racket

(define (square x) (* x x))

;Unfortunately, defining square-list this way produces the answer
; list in the reverse order of the one desired. Why?
; Esto es debido a que se van agregando los elementos al principoo de la
; lista "answer", haciendo que resulte en orden inverso
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))

;Louis then tries to fix his bug by interchanging the arguments to cons:
;This doesn't work either. Explain.
;Este falla puesto que se usa de forma erronea el cons puesto
;que se pone antes el answer que el resultado de square, esto hace
;que no se acumule el resultado de forma correcta.
(define (square-list2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square 
                     (car things))))))
  (iter items '()))

(square-list2 (list 1 2 3 4))