#lang racket

(require math/statistics)

(define (next-line-it file)
  (let loop ((line (read-line file 'any))
             (points '()))
    (if (eof-object? line)
        (reverse points) ; Devuelve la lista de puntos al final de la lectura
        (let* ((values (string-split line " ")) ; Divide la línea en dos valores
               (x (string->number (first values))) ; Convierte el primer valor a número
               (y (string->number (second values))) ; Convierte el segundo valor a número
               (point (list x y))) ; Crea una lista con x e y
          (loop (read-line file 'any) (cons point points))))))


; Llamada para leer el archivo y almacenar los puntos
(define puntos
  (call-with-input-file "ej_pts_europa.txt" next-line-it))

(displayln puntos)


(define (square x) (* x x))

(define (distancia-euc list1 list2)
  (+ (square (- (car list1) (car list2))) (square (- (car (cdr list1)) (car (cdr list2))))))

(define (puntos-mas-cercanos list)
  (define distancia-minima +inf.0) ; Inicializar con un valor muy grande
  (define punto-minimo1 '(0, 0))
  (define punto-minimo2 '(0, 0))
  
  )
  