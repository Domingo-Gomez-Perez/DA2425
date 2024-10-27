#lang racket


; black box
; encapsulamiento, proceso iterativo
(define (lines-to-list file)
  (define (lines-to-list-iter file lista)
    (let ((linea (read-line file 'any)))  ; leer la línea actual
      (if (eof-object? linea)
          lista  ; si es el final del archivo, devolver la lista
          (lines-to-list-iter file (cons (formatear-linea linea) lista)))))  ; agregar la línea y llamar recursivamente

  (cdr(reverse (lines-to-list-iter file '()))))  ; empezamos con una lista vacía y luego la invertimos

(define (formatear-linea linea)
(let* ((values (string-split line " ")) ; Divide la línea en dos valores
               (x (string->number (first values))) ; Convierte el primer valor a número
               (y (string->number (second values))) ; Convierte el segundo valor a número
               (point (list x y))))) ; Crea una lista con x e y

; llamada para leer un archivo.
; (call-with-input-file "ej_pts_01.txt" next-line-it)
; (sort (list 5 3 4) <) ; Ordenar una lista
; (string-split "20 0" " ") ; separar un string por un espacio
; (string->number "20") ; Convertir un string en un numero

(define puntos (call-with-input-file "ej_pts_europa.txt" lines-to-list))

(display puntos)