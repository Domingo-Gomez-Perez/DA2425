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

(define (segunda-mitad lista)
  (let ((len (length lista)))
    (if (odd? len)
        (cons (car lista) (segunda-mitad-rec (ordena-lista-menor (cdr lista)) (- len 1)))
        (segunda-mitad-rec (ordena-lista-menor lista) (length lista))))
  )

(define (segunda-mitad-rec lista longitud)
  (if (or (= (length lista) (quotient longitud 2)) (null? lista))
      lista
      (segunda-mitad-rec (cdr lista) longitud)
      )
 )

(define (primera-mitad lista)
  (primera-mitad-rec (ordena-lista-menor lista) (quotient (length lista) 2)))

(define (primera-mitad-rec lista longitud)
  (if (or (null? lista) (zero? longitud))
      '()  ; Caso base: devolver una lista vacía
      (cons (car lista) (primera-mitad-rec (cdr lista) (- longitud 1)) )
  )
)

;longitud de la lista
(length lista)

;si se prueba no simultaneamente primera-mited y segunda mitad sin el length se ve donde empieza y donde acaba 
;(0 . 0) primer elemento cuando se usa lista, si se usa lista - el primero, el primero es (0 . 2)
(length (primera-mitad (cdr lista)))
;(10.4975 . 62336.2)) ultimo elemento

;(10.4976 . 16911.7) primer elemento
(length (segunda-mitad (cdr lista)))
;(20 . 2) ultimo elemento

;definir la función completa
(define (divide_en_2 lista) (cons (primera-mitad lista) (segunda-mitad lista)))

;funciona con listas pares
(length (car (divide_en_2 lista)))
(length (cdr (divide_en_2 lista)))

;funciona con listas impares
(length (car (divide_en_2 (cdr lista))))
(length (cdr (divide_en_2 (cdr lista))))


