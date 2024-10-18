#lang racket
(define (next-line-it file)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
      (cons line (next-line-it file)))))

(define results (call-with-input-file "ej_pts_01.txt" next-line-it)) ;Te lo da como una lista de strings. OJO, los pares vienen en un solo String, luego los separo en dos
;(car results)
;(displayln "NADA")
;(cdr results)

(define (convert-into-pairs-list abomination)
  (define (string-iterado lista-strs) (car lista-strs))
  (define (corte-string pedazo-str) (string-split pedazo-str " "))
  (define (num-izq str-cortado1) (string->number (car str-cortado1)))
  (define (num-der str-cortado2) (string->number (cadr str-cortado2)))
  
  (cond ((string=? (car abomination) "))")  null)
        (else  (cons (cons (num-izq (corte-string (string-iterado abomination)))
                           (num-der(corte-string (string-iterado abomination))))
                     (convert-into-pairs-list (cdr abomination))))))

(define (ordena-lista-menor lista)
  (sort lista (lambda (a b) (< (car a) (car b)))))

(define lista (convert-into-pairs-list (cdddr results)))

;(ordena-lista-menor lista)

(define (segunda-mitad lista longitud)
  (if (= (length lista) (/ longitud 2))
      lista
      (segunda-mitad (cdr lista) longitud)
      )
 )

(define (primera-mitad-aux lista1 lista2 longitud)
  (if (= (length lista) (/ longitud 2))
      lista1
      (primera-mitad-aux (append (list lista1) (list (car lista2))) (cdr lista2) longitud)
      )
 )

(define (primera-mitad list)
  (primera-mitad-aux (car lista) (cdr lista) (length lista))
  )

(primera-mitad (list 1 2 3 4))

(segunda-mitad (list 1 2 3 4) 4)
