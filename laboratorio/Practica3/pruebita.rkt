#lang racket

; Función que convierte las líneas de un archivo en una lista de puntos
(define (lines-to-list file)
  (define (lines-to-list-iter file lista)
    (let ((linea (read-line file 'any)))  ; leer la línea actual
      (if (eof-object? linea)
          lista  ; si es el final del archivo, devolver la lista
          (lines-to-list-iter file (cons (formatear-linea linea) lista)))))  ; agregar la línea y llamar recursivamente

  (cdr (reverse (lines-to-list-iter file '()))))  ; empezamos con una lista vacía y luego la invertimos

; Función para formatear cada línea y convertirla en un punto (par de coordenadas)
(define (formatear-linea linea)
  (let* ((values (string-split linea " ")) ; Divide la línea en dos valores
         (x (string->number (first values))) ; Convierte el primer valor a número
         (y (string->number (second values))) ; Convierte el segundo valor a número
         (point (list x y))) ; Crea una lista con x e y
    point))

; Llamada para leer el archivo y almacenar los puntos
(define puntos (call-with-input-file "ej_pts_europa.txt" lines-to-list))

; Mostrar los puntos leídos
(display puntos)