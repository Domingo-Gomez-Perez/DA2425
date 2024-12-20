#lang racket
;Definicion de la funcion que da la lista de coordenadas
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

(define ciudades-1 (lector "ej_pts_01.txt"))

(define (encuentra-mejor ciudades)
  (define (coord-x ciudad) (car ciudad))
  (define (coord-y ciudad) (cdr ciudad))
  (define tamanho-lista (length ciudades))
  
  (define (distancia x1 y1 x2 y2) (+ (expt (- x2 x1) 2) (expt (- y2 y1) 2)))
  
  (define (bucle-1 i par-mejor-ciudades distancia-mejor-ciudades)
    (display i)
    (newline)
    (if (= i tamanho-lista) ;tamanho-lista
        par-mejor-ciudades
        (let ((mejor (bucle-2 (list-ref ciudades i) 0 par-mejor-ciudades distancia-mejor-ciudades)))
              
              (bucle-1 (+ i 1) (car mejor) (cdr mejor)))))
  
  (define (bucle-2 ciudad-bucle-1 j par-mejor-ciudades distancia-mejor-ciudades)
    (if (= j tamanho-lista)
        (cons par-mejor-ciudades distancia-mejor-ciudades)
        (let* ((ciudad-a-evaluar-2 (list-ref ciudades j))
               (distancia-nueva (distancia (coord-x ciudad-bucle-1) (coord-y ciudad-bucle-1) (coord-x ciudad-a-evaluar-2) (coord-y ciudad-a-evaluar-2))))
              
              (if (and (> distancia-mejor-ciudades distancia-nueva) (not (and (= (coord-x ciudad-bucle-1) (coord-x ciudad-a-evaluar-2)) (= (coord-y ciudad-a-evaluar-2) (coord-y ciudad-a-evaluar-2)))))
                  (bucle-2 ciudad-bucle-1 (+ j 1) (cons ciudad-bucle-1 ciudad-a-evaluar-2) distancia-nueva)
                  (bucle-2 ciudad-bucle-1 (+ j 1) par-mejor-ciudades distancia-mejor-ciudades)))))
  (display tamanho-lista)
  (newline)
  (bucle-1 0 null +inf.0))

(encuentra-mejor ciudades-1)

;Pregunta 2: Las dos ciudades más cercanas entre sí son las que se encuentran en (20, 0) y (10.8938 0).

;Pregunta 3: El algoritmo tiene complejidad temporal O(n^2) ya que por cada ciudad se comparan
;todas las ciudades y porque la lectura de las ciudades es O(n). Las llamadas del bucle interior
;(bucle-2) son de recursión de cola (iterativas) así como las del bucle exterior (bucle-1). Por lo
;tanto el algoritmo tiene complejidad espacial O(1).




