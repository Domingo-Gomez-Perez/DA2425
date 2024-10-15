#lang racket
(require math/statistics)

(define (next-line-it file)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
      ;(displayln line)
      (cons line (next-line-it file))
      ;(next-line-it file))))
      )))

(define (length s)
    (if (null? s)
        0
	(+ 1 (length (cdr s)))))

;(string-split "20 0" " ")
;(string->number "20")

; llamada para leer un archivo.
;(call-with-input-file "ej_pts_europa.txt" next-line-it)
;(sort (call-with-input-file "ej_pts_europa.txt" next-line-it) <) ; Ordenar una lista

;(define (convierte lista length) (
;    convierte-iter lista 0 length
;                                  ))

;(define (convierte-iter lista i length listaDevuelta) (
;    if (= i length)
;       (devuelve-ultima-pareja lista listaDevuelta)
;       (convierte-iter lista (+ i 1) length)
;                                         ))

;(cons (string->number (car (string-split "20 0" " "))) (string->number (car (cdr (string-split "20 0" " ")))))

(define (devuelveLista lista) (
    if (void? lista)
       null
       (if (null? lista)
           lista
           (cons (cons (string->number (car (string-split (car lista) " "))) (string->number (car (cdr (string-split (car lista) " "))))) (devuelveLista (cdr lista)));(string->number (car (cdr (string-split "20 0" " ")))))
                                        )))

;(define (listaPrueba) (list "0 1" "2 3" "4 5"))

;(devuelveLista (call-with-input-file "ej_pts_europa.txt" next-line-it))
(devuelveLista (call-with-input-file "ej_pts_europa.txt" next-line-it))