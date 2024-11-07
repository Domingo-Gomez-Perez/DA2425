#lang racket
(require math/statistics)
;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Pregunta 01 ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
; Viena <-> Bratislava 

;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Pregunta 02 ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
(define (euclidean-distance p1 p2)
  (sqrt (+ (sqr (- (first p1) (first p2)))
           (sqr (- (second p1) (second p2))))))

;;;;;;;;;;;;;;;;;;;;;;;PRUEBA.RKT:;;;;;;;;;;;;;;;;;;;;;;;;
(require math/statistics)

(define (next-line-it file)
  (let loop ()
    (let ((line (read-line file 'any)))
      (unless (eof-object? line)
        (displayln line)
        (loop)))))

(call-with-input-file "./ej_pts_01.txt" next-line-it)

; llamada para leer un archivo.
;(call-with-input-file "ej_pts_01.txt" next-line-it)
(sort (list 5 3 4) <) ; Ordenar una lista
(string-split "20 0" " ") ; separar un string por un espacio
(string->number "20") ; Convertir un string en un numero
;;;;;;;;;;;;;;;;;;;;;;;PRUEBA.RKT:;;;;;;;;;;;;;;;;;;;;;;;;
