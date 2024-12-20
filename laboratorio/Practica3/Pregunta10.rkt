#lang racket

; Función para calcular la distancia euclídea
(define (distance p1 p2)
  (sqrt (+ (expt (- (car p1) (car p2)) 2)
           (expt (- (cdr p1) (cdr p2)) 2))))

; Preprocesar puntos: ordenar por coordenadas X e Y
(define (preprocesar puntos)
  (let ([ordenado-x (sort puntos (lambda (p1 p2) (< (car p1) (car p2))))]
        [ordenado-y (sort puntos (lambda (p1 p2) (< (cdr p1) (cdr p2))))])
    (list ordenado-x ordenado-y)))

; Algoritmo recursivo para encontrar los puntos más cercanos
(define (distancia-recursiva ordenado-x ordenado-y)
  (let ([n (length ordenado-x)])
    (if (< n 4)
        ; Caso base: fuerza bruta para pocas entradas
        (let ([minimo +inf.0]
              [pares '()])
          (let ([combinaciones (apply append (map (lambda (i)
                                                   (map (lambda (j) (list i j)) (range (+ i 1) n)))
                                                 (range n)))])
            (for-each (lambda (indices)
                        (let* ([i (first indices)]
                               [j (second indices)]
                               [d (distance (list-ref ordenado-x i) (list-ref ordenado-x j))])
                          (when (< d minimo)
                            (set! minimo d)
                            (set! pares (list (list-ref ordenado-x i) (list-ref ordenado-x j))))))
                      combinaciones))
          (values minimo pares))
        ; Caso recursivo
        (let* ([mitad (quotient n 2)]
               [x-mitad (car (list-ref ordenado-x mitad))]
               [izq-x (take ordenado-x mitad)]
               [der-x (drop ordenado-x mitad)]
               [izq-y (filter (lambda (p) (<= (car p) x-mitad)) ordenado-y)]
               [der-y (filter (lambda (p) (> (car p) x-mitad)) ordenado-y)]
               [izq-res (call-with-values (lambda () (distancia-recursiva izq-x izq-y)) list)]
               [der-res (call-with-values (lambda () (distancia-recursiva der-x der-y)) list)]
               [delta (min (first izq-res) (first der-res))]
               [delta-pares (if (< (first izq-res) (first der-res))
                               (second izq-res)
                               (second der-res))]
               [banda (filter (lambda (p) (<= (abs (- (car p) x-mitad)) delta)) ordenado-y)])
          ; Buscar en la banda
          (let ([banda-min delta]
                [banda-pares delta-pares]
                [banda-combinaciones (apply append (map (lambda (i)
                                                          (map (lambda (j) (list i j))
                                                               (range (+ i 1) (min (+ i 6) (length banda)))))
                                                        (range (length banda))))])
            (for-each (lambda (indices)
                        (let* ([i (first indices)]
                               [j (second indices)]
                               [d (distance (list-ref banda i) (list-ref banda j))])
                          (when (< d banda-min)
                            (set! banda-min d)
                            (set! banda-pares (list (list-ref banda i) (list-ref banda j))))))
                      banda-combinaciones)
            (if (< banda-min delta)
                (values banda-min banda-pares)
                (values delta delta-pares)))))))

; Función principal
(define (distancia-minima puntos)
  (let* ([preproceso (preprocesar puntos)]
         [ordenado-x (car preproceso)]
         [ordenado-y (cadr preproceso)])
    (distancia-recursiva ordenado-x ordenado-y)))

; Leer puntos desde un archivo
(define (leer-puntos archivo)
  (call-with-input-file archivo
    (lambda (file)
      (let loop ([linea (read-line file 'any)] [acum '()])
        (if (eof-object? linea)
            (reverse acum)
            (let* ([coords (map string->number (string-split linea " "))]
                   [punto (if (and (real? (first coords)) (real? (second coords)))
                              (cons (first coords) (second coords))
                              (error "Punto inválido en archivo" coords))])
              (loop (read-line file 'any) (cons punto acum))))))))

; Ejecución principal
(define (calcular-desde-archivo archivo)
  (let* ([puntos (leer-puntos archivo)]
         [resultado (call-with-values (lambda () (distancia-minima puntos)) list)])
    (displayln (format "Distancia mínima: ~a" (first resultado)))
    (displayln (format "Puntos más cercanos: ~a" (second resultado)))))

; Ejecutar ejemplo
(calcular-desde-archivo "ej_pts_europa.txt")
