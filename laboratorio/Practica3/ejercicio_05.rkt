#lang racket

; Función para dividir una lista de puntos en dos subconjuntos P1 y P2

(define (primeros-n lista n)
  (if(= n 0)
  ('())
  (list(car lista) (primeros-n (cdr lista) (- n 1)))))

(define (ultimos-n lista n)
  (if(= n 0)
  (lista)
  ((ultimos-n (cdr lista) (- n 1)))))

(define (dividir-puntos puntos)
  (let* ((puntos-ordenados (sort puntos (lambda (p1 p2) (<= (car p1) (car p2)))))
         (n (length puntos-ordenados))
         (mitad (quotient n 2))
         (P1 (take puntos-ordenados mitad))
         (P2 (drop puntos-ordenados mitad))
         (x0 (car (last P1)))) ; El x del último punto de P1
    (list P1 P2 x0)))

; Ejemplo de uso
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

(dividir-puntos puntos)