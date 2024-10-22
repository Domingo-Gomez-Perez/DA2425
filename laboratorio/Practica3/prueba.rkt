#lang racket

 (require math/statistics)

(define (next-line-it file)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
      (displayln line)
      (next-line-it file))))
; llamada para leer un archivo.
;(call-with-input-file "ej_pts_01.txt" next-line-it)
<<<<<<< HEAD
(sort (list 5 3 4) <) ; Ordenar una lista
=======
(sort (list 5 3 4) <) ; Ordenar una lista
(string-split "20 0" " ") ; separar un string por un espacio
(string->number "20") ; Convertir un string en un numero
>>>>>>> e79d6835dd790ac94f3eb41e30aee275909cf3b1
