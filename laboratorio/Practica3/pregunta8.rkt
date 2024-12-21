
#lang racket
;8) Escribe un algoritmo completo para la búsqueda de una pareja de puntos con distancia mínima,
;combinando la respuesta del ejercicio (7) con la búsqueda exhaustiva de los puntos en estas
;bandas.
(require math/statistics)

; Función para verificar si todos los elementos cumplen una condición
(define (every pred lista)
  (cond
    [(null? lista) #t]
    [(not (pred (car lista))) #f]
    [else (every pred (cdr lista))]))

; Función para leer puntos desde un archivo
(define (leer-puntos archivo)
  (call-with-input-file archivo
    (lambda (file)
      (let loop ((linea (read-line file 'any)) (puntos '()))
        (if (eof-object? linea)
            (reverse puntos)
            (let ((coord (map string->number (string-split linea " "))))
              (if (and (= (length coord) 2) (every number? coord))
                  (loop (read-line file 'any) (cons coord puntos))
                  (loop (read-line file 'any) puntos))))))))

; Calcula la distancia entre dos puntos
(define (distancia p1 p2)
  (sqrt (+ (sqr (- (car p1) (car p2)))
           (sqr (- (cadr p1) (cadr p2))))))

; Divide los puntos en dos sublistas balanceadas
(define (dividir-puntos puntos)
  (let* ([n (length puntos)]
         [mitad (quotient n 2)]
         [x0 (car (list-ref puntos mitad))]
         [P1 (filter (lambda (punto) (<= (car punto) x0)) puntos)]
         [P2 (filter (lambda (punto) (> (car punto) x0)) puntos)])
    (list P1 P2 x0)))

; Genera las bandas limitadas por coordenadas
(define (filtrar-bandas puntos x0 delta)
  (filter (lambda (p)
            (and (>= (car p) (- x0 delta))
                 (<= (car p) (+ x0 delta))))
          puntos))

; Busca la distancia mínima entre dos bandas
(define (buscar-en-bandas B1 B2 delta)
  (let bucle ((i 0) (j 0) (mejor-dist delta) (mejor-par '()))
    (if (>= i (length B1))
        (list mejor-dist mejor-par)
        (let* ([p1 (list-ref B1 i)]
               [j (let avanzar-j ((j j))
                    (if (and (< j (length B2))
                             (<= (cadr (list-ref B2 j)) (- (cadr p1) delta)))
                        (avanzar-j (+ j 1))
                        j))])
          (let loop ((k 0) (dist-min mejor-dist) (par-min mejor-par))
            (if (or (>= k 5) (>= (+ j k) (length B2)))
                (bucle (+ i 1) j dist-min par-min)
                (let* ([p2 (list-ref B2 (+ j k))]
                       [dist (distancia p1 p2)])
                  (if (< dist dist-min)
                      (loop (+ k 1) dist (list p1 p2))
                      (loop (+ k 1) dist-min par-min)))))))))

; Encuentra la pareja de puntos más cercana recursivamente
(define (pareja-cercana puntos)
  (if (<= (length puntos) 3)
      (let loop ((i 0) (mejor-dist +inf.0) (mejor-par '()))
        (if (>= i (length puntos))
            (list mejor-dist mejor-par)
            (let loop-j ((j (+ i 1)) (dist-min mejor-dist) (par-min mejor-par))
              (if (>= j (length puntos))
                  (loop (+ i 1) dist-min par-min)
                  (let ([dist (distancia (list-ref puntos i) (list-ref puntos j))])
                    (if (< dist dist-min)
                        (loop-j (+ j 1) dist (list (list-ref puntos i) (list-ref puntos j)))
                        (loop-j (+ j 1) dist-min par-min)))))))
      (let* ([div (dividir-puntos puntos)]
             [P1 (car div)]
             [P2 (cadr div)]
             [x0 (caddr div)]
             [delta1 (pareja-cercana P1)]
             [delta2 (pareja-cercana P2)]
             [delta (min (car delta1) (car delta2))]
             [B1 (filtrar-bandas P1 x0 delta)]
             [B2 (filtrar-bandas P2 x0 delta)]
             [delta-bandas (buscar-en-bandas B1 B2 delta)])
        (if (< (car delta-bandas) delta)
            delta-bandas
            (if (< (car delta1) (car delta2))
                delta1
                delta2)))))

; Función principal
(define (main archivo)
  (define puntos (leer-puntos archivo))
  (define ordenados (sort puntos (lambda (p1 p2) (< (car p1) (car p2))))) ; Ordenar por coordenada x
  (define resultado (pareja-cercana ordenados))
  (printf "La distancia mínima es ~a entre los puntos ~a y ~a\n"
          (car resultado) (cadr (cadr resultado)) (car (cadr resultado))))

; Prueba con archivo de ejemplo
(main "ej_pts_01.txt")
