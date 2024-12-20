#lang racket

; Función para calcular la distancia euclídea
(define (distance p1 p2)
  (sqrt (+ (expt (- (car p1) (car p2)) 2)
           (expt (- (cdr p1) (cdr p2)) 2))))

; Duplicar X en Y, ordenado por coordenada y
(define (duplicar-y puntos)
  (sort puntos (lambda (p1 p2) (< (cdr p1) (cdr p2)))))

; Dividir X en dos listas X1 y X2 en tiempo lineal
(define (dividir-x puntos)
  (let* ((n (length puntos))
         (medio (quotient n 2)))
    (list (take puntos medio) ; X1
          (drop puntos medio)))) ; X2

; Dividir Y en Y1 y Y2 en tiempo lineal, basado en el rango de X1 y X2
(define (dividir-y y puntos-x1 puntos-x2)
  (let ((x1-max (car (last puntos-x1)))) ; Máxima abscisa de X1
    (foldr (lambda (punto acc)
             (let ((y1 (car acc))
                   (y2 (cdr acc)))
               (if (<= (car punto) x1-max)
                   (cons (cons punto y1) y2) ; Agregar a Y1
                   (cons y1 (cons punto y2))))) ; Agregar a Y2
           (cons '() '())
           y)))

; Encontrar distancia mínima en una lista pequeña
(define (distancia-minima-directa puntos)
  (let ((n (length puntos)))
    (if (< n 2)
        (list +inf.0 '()) ; Retorna infinito y una lista vacía
        (foldl (lambda (i acc)
                 (foldl (lambda (j acc-inner)
                          (let* ((p1 (list-ref puntos i))
                                 (p2 (list-ref puntos j))
                                 (d (distance p1 p2)))
                            (if (< d (car acc-inner))
                                (list d (list p1 p2))
                                acc-inner)))
                        acc
                        (range (+ i 1) n)))
               (list +inf.0 '())
               (range n)))))

; Recursión para encontrar la mínima distancia
(define (distancia-recursiva x y)
  (if (< (length x) 2)
      (list +inf.0 '()) ; Caso base: no hay distancia si hay menos de 2 puntos
      (let* ((div-x (dividir-x x))
             (x1 (first div-x))
             (x2 (second div-x))
             (div-y (dividir-y y x1 x2))
             (y1 (car div-y))
             (y2 (cdr div-y))
             (delta1 (distancia-recursiva x1 y1))
             (delta2 (distancia-recursiva x2 y2))
             (delta (if (< (car delta1) (car delta2)) delta1 delta2)))
        (let* ((y-frontera (filter (lambda (punto)
                                     (<= (abs (- (car punto) (car (last x1))))
                                         (car delta)))
                                   y))
               (delta-frontera (distancia-minima-directa y-frontera)))
          (if (< (car delta-frontera) (car delta))
              delta-frontera
              delta)))))

; Función principal
(define (calcular-distancia-minima puntos)
  (let* ((x puntos)
         (y (duplicar-y puntos))  ; Crear Y ordenado por ordenadas
         (resultado (distancia-recursiva x y)))
    (values (car resultado) (cadr resultado))))

; Función para leer puntos desde un archivo
(define (next-line-it file)
  (let ((line (read-line file 'any)))  ; Lee una línea del archivo
    (if (eof-object? line)  ; Si el final del archivo se ha alcanzado
        '()  ; Retorna una lista vacía
        (let ((coords (map string->number (string-split line " "))))  ; Convierte la línea en números
          (if (and (number? (car coords)) (number? (cadr coords)))  ; Verifica si hay dos números válidos
              (cons (cons (car coords) (cadr coords))  ; Crea un par (x, y)
                    (next-line-it file))  ; Llama recursivamente para la siguiente línea
              (next-line-it file))))))  ; Ignora líneas no válidas y continúa con la siguiente

; Leer puntos desde un archivo y calcular la distancia mínima
(define (calcular-desde-archivo archivo)
  (call-with-input-file archivo
    (lambda (file)
      (let ((puntos (next-line-it file))) ; Leer puntos desde el archivo
        (let-values ([(distancia pares) (calcular-distancia-minima puntos)])
          (begin
            (displayln (format "Distancia mínima: ~a" distancia))
            (displayln (format "Puntos más cercanos: ~a" pares))))))))

; Ejecutar ejemplo con archivo
(calcular-desde-archivo "ej_pts_europa.txt")
