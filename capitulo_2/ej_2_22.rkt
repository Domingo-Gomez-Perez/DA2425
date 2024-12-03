#lang racket

; Primer metodo
(define (square-list1 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (sqr (car things))
                    answer))))
  (iter items null))
; En este metodo, el problema es el uso del cons ya que lo que hace es agregar el cuadrado del primer elemento
; al inicio de la lista answer en cada paso recursivo.

; Al hacer esto ocurre lo siguiente
; Si items es (1 2 3 4) (como en el ejemplo), la secuencia de llamadas recursivas dara este resultado;
; (cons (sqr 1) null) -> (1).
; (cons (sqr 2) (1)) -> (4 1).
; (cons (sqr 3) (4 1)) -> (9 4 1).
; (cons (sqr 4) (9 4 1)) -> (16 9 4 1).

; --------------------------------------------------------------------------------

; Segundo metodo
(define (square-list2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (sqr 
                     (car things))))))
  (iter items null))
; En este metodo, el problema vuelve a estar en el uso de cons. Lo que hace cons es tomar dos argumentos (en este caso una lista y un numero)
; y hace una nueva lista. En este caso, al intercambiar los argumentos y poner en el otro lado la lista, crea listas anidas que, aunque tiene el orden
; correcto no es una buena solucion.