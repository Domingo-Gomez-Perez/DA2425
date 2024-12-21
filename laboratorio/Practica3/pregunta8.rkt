#lang racket
(define (lector nombre-fichero)
  (define (next-line-it file)
    (let ((line (read-line file 'any)))
      (unless (eof-object? line)
        (cons line (next-line-it file)))))
   
  (define results (call-with-input-file nombre-fichero next-line-it)) ;Te lo da como una lista de strings. OJO, los pares vienen en un solo String, luego los separo en dos
  
  (define (convert-into-pairs-list abomination)
    (define (string-iterado lista-strs) (car lista-strs))
    (define (corte-string pedazo-str) (string-split pedazo-str " "))
    (define (num-izq str-cortado1) (string->number (car str-cortado1)))
    (define (num-der str-cortado2) (string->number (cadr str-cortado2)))
    
    (cond ((string=? (car abomination) "))")  null)
          (else  (let ((cacho-cortado (corte-string (string-iterado abomination))))
                   (cons (cons (num-izq cacho-cortado)
                               (num-der cacho-cortado))
                         (convert-into-pairs-list (cdr abomination)))))))
  
  (convert-into-pairs-list (cdddr results)))

(define lista (lector "ej_pts_01.txt"))

(define (ordena-lista-menor lista)
  (sort lista (lambda (a b) (< (car a) (car b)))))

;Aqui ya suponemos la lista ordenada
(define (segunda-mitad lista)
  (define (segunda-mitad-rec lista longitud)
    (if (or (= (length lista) (quotient longitud 2)) (null? lista))
        lista
        (segunda-mitad-rec (cdr lista) longitud)
        )
    )
  (let ((len (length lista)))
    (if (odd? len)
        (cons (car lista) (segunda-mitad-rec (cdr lista) (- len 1)))
        (segunda-mitad-rec lista len)))
  )
(define (primera-mitad lista)
  (define (primera-mitad-rec lista longitud)
    (if (or (null? lista) (zero? longitud))
        '()  ; Caso base: devolver una lista vacía
        (cons (car lista) (primera-mitad-rec (cdr lista) (- longitud 1)) )
        )
    )
  (primera-mitad-rec lista (quotient (length lista) 2)))



(define (encuentra-mejor-par-falso lista)
  (define (coord-x ciudad) (car ciudad))
  (define (coord-y ciudad) (cdr ciudad))
  (define (ordena-lista-menor lista)
    (sort lista (lambda (a b) (< (car a) (car b)))))
  (define (nuevo-mejor-par ciudad1 par-ciudades)
    (let ((nuevo-par (if (primer-par-mas-cerca?
                          (cons ciudad1 (cons (car par-ciudades) null))
                          (cons ciudad1 (cdr par-ciudades)))
                        (cons ciudad1 (cons (car par-ciudades) null))
                        (cons ciudad1 (cdr par-ciudades)))))

      (if (primer-par-mas-cerca? nuevo-par par-ciudades)
          nuevo-par
          par-ciudades))
    )
  (define (primer-par-mas-cerca? par1 par2)
    (< (distancia (coord-x (car par1)) (coord-y (car par1)) (coord-x (cadr par1)) (coord-y (cadr par1)))
       (distancia (coord-x (car par2)) (coord-y (car par2)) (coord-x (cadr par2)) (coord-y (cadr par2)))))
  (define (distancia x1 y1 x2 y2) (+ (expt (- x2 x1) 2) (expt (- y2 y1) 2)))

  (define (back-tracker lista)
    (if (odd? (length lista))
        (nuevo-mejor-par (car lista) (back-tracker (cdr lista)))
        (if (= (length lista) 2)
            lista
            (let ((mejores-izq (back-tracker (primera-mitad lista)))
                  (mejores-der (back-tracker (segunda-mitad lista))))
              (if (primer-par-mas-cerca? mejores-izq mejores-der)
                  mejores-izq
                  mejores-der))
            )
        )
    )

  (let ((len (length lista))
        (lista-ordenada (ordena-lista-menor lista)))
    (if (odd? len)
        (let ((x (back-tracker (cdr lista))))
            (if (primer-par-mas-cerca? (cons (car lista) (car x)) (cons (car lista) (cdr x)))
            (cons (car lista) (car x))
            (cons (car lista) (cdr x))))
        (back-tracker lista-ordenada)))
  )

(encuentra-mejor-par-falso (list (cons 2 3) (cons 4 5) (cons 6 7) (cons 9 10) (cons 13 14) (cons 33 34)))

(encuentra-mejor-par-falso lista)

;Poner 1 comentario por metodo



