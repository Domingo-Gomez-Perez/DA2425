#lang racket

(define (next-line-it file)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
      (cons line (next-line-it file)))))

(define results (call-with-input-file "ej_pts_01.txt" next-line-it)) ;Te lo da como una lista de strings. OJO, los pares vienen en un solo String, luego los separo en dos

(define (convert-into-pairs-list abomination)
  (define (string-iterado lista-strs) (car lista-strs))
  (define (corte-string pedazo-str) (string-split pedazo-str " "))
  (define (num-izq str-cortado1) (string->number (car str-cortado1)))
  (define (num-der str-cortado2) (string->number (cadr str-cortado2)))
  
  (cond ((string=? (car abomination) "))")  null)
        (else  (cons (cons (num-izq (corte-string (string-iterado abomination)))
                           (num-der(corte-string (string-iterado abomination))))
                     (convert-into-pairs-list (cdr abomination))))))

(define lista (convert-into-pairs-list (cdddr results))) ;Definición de variable principal

(define (ordena-lista-menor-abcisas lista) ;TODO: ¿car es la pos en el eje de abcisas?
  (sort lista (lambda (a b) (< (car a) (car b)))))

(define (ordena-lista-menor-ordenadas lista) ;TODO: ¿cdr es la pos en el eje de ordeanadas?
  (sort lista (lambda (a b) (< (cdr a) (cdr b)))))

;Devuelve un cons con una lista de la primera mitad en la izquierda y una lista segunda mitad en cada lado
(define (divide-lista-mitad lista)
  (define (obten-mitad tamanho)
    (if (odd? tamanho)
        (/ (- tamanho 1) 2)
        (/ tamanho 2)))

  (define mitad-len (obten-mitad (length lista)))
   
  (define (divide-lista-mitad-rec lista-restante cont)
    
    (cond ((<= cont mitad-len) (let ((return-pair (divide-lista-mitad-rec (cdr lista-restante) (+ cont 1))))
                                (cons (car return-pair) (cons (car lista-restante) (cdr return-pair)))))
          ((> cont mitad-len) (cons lista-restante null))
          )
         
    )
    
    (let ((return-value (divide-lista-mitad-rec lista 1)))
      (cons (cdr return-value) (car return-value)))
  )

(define (distancia x1 y1 x2 y2) (+ (expt (- x2 x1) 2) (expt (- y2 y1) 2)))
(define (coord-x ciudad) (car ciudad))
(define (coord-y ciudad) (cdr ciudad))


(define (pareja-mas-cercana lista)
  (define (fuerza-bruta ciudades) ;Pregunta 1
    (define tamanho-lista (length ciudades))
  
    (define (distancia x1 y1 x2 y2) (+ (expt (- x2 x1) 2) (expt (- y2 y1) 2)))
  
    (define (bucle-1 i par-mejor-ciudades distancia-mejor-ciudades)
      (if (= i tamanho-lista) ;tamanho-lista
          (cons distancia-mejor-ciudades
                par-mejor-ciudades)
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
    (bucle-1 0 null +inf.0))
  
  (define (combinar izquierda derecha delta)
    (define (filtrar-banda izquierda derecha delta)
      (define divisoria-x  (car (last izquierda))) ; Coordenada x del último punto en izquierda
      (cons (filter (lambda (p)
                (< (abs (- (car p) divisoria-x)) delta))
              izquierda )
            (filter (lambda (p)
                (< (abs (- (car p) divisoria-x)) delta))
              derecha )))) ; Combinar las listas izquierda y derecha

    (define (obtiene-YL-YR Y izquierda derecha)
      (define YL (list)) ; Lista para los puntos de la izquierda
      (define YR (list)) ; Lista para los puntos de la derecha
      (for ([p Y]) ; Iterar sobre cada punto en Y
        (if (hash-has-key? izquierda p) ; Verificar si el punto está en el hash `izquierda`
            (set! YL (cons p YL)) ; Agregar a `YL` si está en `izquierda`
            (if (hash-has-key? derecha p) (set! YR (cons p YR))))) ; Agregar a `YR` si está en `derecha`
      (append (reverse YL) (reverse YR))) ; Retornar `YL` y `YR` en orden original
        
    (define (bucle banda)
      (define min-dist +inf.0)                
      (define mejor-pareja null)                
      (for ([i (in-range (length banda))])
        (for ([j (in-range (+ i 1) (min (+ i 7) (length banda)))])
          (let* ((ciudad1 (list-ref banda i))
                 (ciudad2 (list-ref banda j))
                 (d (distancia (coord-x ciudad1) (coord-y ciudad1) (coord-x ciudad2) (coord-y ciudad2))))
            (if (< d min-dist)
                (set! min-dist d)
                (set! mejor-pareja (list (list-ref banda i) (list-ref banda j)))))))
      (cons min-dist mejor-pareja))
    
  
    (let*  ((bandas (filtrar-banda
                     izquierda derecha
                     delta))
            (capsula (obtiene-YL-YR lista-ordenada-unica-y (convertir-a-tabla (car bandas)) (convertir-a-tabla (cdr bandas))))
            ;(banda (ordena-lista-menor-abcisas (filtrar-banda izquierda derecha delta)))
            
            )
      (bucle banda))

  (define (convertir-a-tabla lista)
    (define (transformar-lista lista)
      (for/list ([par lista]) ; Itera sobre cada par en la lista original
        (cons (car par)       ; Mantiene el primer elemento del par
              (cons (car par) (cdr par))))) ; Sustituye el segundo elemento por (h (h 2))
    (make-hash (transformar-lista lista)))


  
  (define (delta capsula) (car capsula))
  (define (pareja capsula) (cdr capsula))
  
  ;Función que va dividiendo
  (define (pareja-mas-cercana-rec lista)
    (if (<= (length lista) 3)
        ;Caso de muy pocos puntos
      (fuerza-bruta lista)
      ;Caso usual
      ;Divide
      (let*  (;(lista-ordenada-y (ordena-lista-menor-ordenadas lista)) ;No nos hace falta
              (lista-cortada  (divide-lista-mitad lista))
              )
        (let  ((mitad  (length (car lista-cortada)))
               ;Backtracker
               (capsula_pareja_izq  (pareja-mas-cercana-rec (car lista-cortada)))
               (capsula_pareja_der  (pareja-mas-cercana-rec (cdr lista-cortada))))
          ;Tomar el mejor de las dos mitades
          (let  ((mejor-capsula (if (< (delta capsula_pareja_izq) (delta capsula_pareja_der))
                                    capsula_pareja_izq
                                    capsula_pareja_der)))
            ;Combinar los resultados
             (let  ((capsula_combinada (combinar  (car lista-cortada) (cdr lista-cortada) (delta mejor-capsula))))
            ;(let  ((capsula_combinada (combinar (convertir-a-tabla (car lista-cortada))
                                                ;(convertir-a-tabla (cdr lista-cortada))
                                                ;(delta mejor-capsula))))
               ;Retornar la sol global))
               (if (< (delta capsula_combinada) (delta mejor-capsula))
                   capsula_combinada
                   mejor-capsula))))))
    )
  
  ;Llamada inicial
  (define lista-ordenada-unica-y (ordena-lista-menor-abcisas lista))
  (pareja-mas-cercana-rec (ordena-lista-menor-ordenadas lista))
  )

(pareja-mas-cercana lista)
;(pareja-mas-cercana (list (cons 2 3) (cons 12 30) (cons 40 50) (cons 5 1) (cons 12 10) (cons 3 4)))