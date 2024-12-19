#lang racket

(require math/statistics)

(define (next-line-it file)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
      (displayln line)
      (next-line-it file))))
; llamada para leer un archivo.
(cons (call-with-input-file "ej_pts_01.txt" next-line-it) null)
(sort (list 5 3 4) <) ; Ordenar una lista