#lang racket
; Función para calcular la distancia al cuadrado entre dos puntos
(define (distancia-cuadrada p1 p2)
  (+ (sqr (- (car p2) (car p1))) (sqr (- (cadr p2) (cadr p1)))))

; Constante necesaria para comparar y encontrar el mínimo.
(define MAX 999999999)

(define (minimo-j elem lista) (
    reduce (lambda (x y) (mini x (distancia-cuadrada elem y))) lista MAX
                                   ))

(define (mini x y) (
    if (< x y)
       x
       y
                   ))

(define (reduce operacion lista valorDefecto) (
    if (null? lista)
       valorDefecto
       (reduce operacion (cdr lista) (operacion valorDefecto (car lista)))
                                               ))

(define (combinar dist-min-izq dist-min-dcha pto-tramo1-ext pto-tramo2-ext lista)
  (let ((pto-medio(/ (+ (car pto-tramo1-ext) (car pto-tramo2-ext)) 2)))
    (let ((dist-min (mini dist-min-izq dist-min-dcha)))
      (let ((lim-izq (- pto-medio dist-min)))
        (let ((lim-dcha (+ pto-medio dist-min)))


          
          (define (combinar-iter pto-medio lim-izq lim-dcha lista punto lista1)

            (cond 
            ((null? punto)
                lista)
            ((and (< lim-izq (car punto)) (> lim-dcha (car punto)))
                     (cons lista punto)))
            (combinar-iter pto-medio lim-izq lim-dcha lista (cadr lista1) (cdr lista1)))


          
          (combinar-iter pto-medio lim-izq lim-dcha lista (cadr lista) (cdr lista))
     
                      )))))

