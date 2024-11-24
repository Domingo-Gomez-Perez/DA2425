;Iterativo
(define (square-listI items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items null))

(square-listI (list 1 2 3 4))
;El resultado está invertido porque cons agrega los valores cuadrados al frente de la lista acumuladora


;Intercambiado
(define (square-listII items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square 
                     (car things))))))
  (iter items null))

(square-listII (list 1 2 3 4))
;En lugar de agregar el valor cuadrado al frente de la lista, el acumulador entero (answer) 
;se está agregando al frente, lo que crea una lista anidada incorrecta