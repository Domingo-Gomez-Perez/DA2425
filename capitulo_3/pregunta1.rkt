#lang racket

 (require math/statistics)

(define (next-line-it1 file)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
      (displayln (string-split line " "))
      (next-line-it file))))

(define (next-line-it file)
  (define min 999999999999999999999999999)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
      (let ([linea (string-split line " ")])
      (let ((valor1 (string->number (car linea)))
            (valor2 (string->number(cadr linea))))
        (define resta (abs valor1 valor2)
                     (if (< resta min)
                         (set! min resta))
                     
      ;(displayln (/ valor2 valor1))
       
      (next-line-it file)))))))

; llamada para leer un archivo.
(call-with-input-file "ej_pts_02.txt" next-line-it)
(sort (list 5 3 4) <) ; Ordenar una lista
(string-split "20 0" " ") ; separar un string por un espacio
(string->number "20") ; Convertir un string en un numero


