#lang racket
(require math/statistics)

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

; Función para calcular la distancia euclídea entre dos puntos
(define (distancia-euclidea p1 p2)
  (sqrt (+ (sqr (- (car p1) (car p2)))
           (sqr (- (cdr p1) (cdr p2))))))

; Función para seleccionar dos puntos aleatorios de una lista  TOCAR
(define (puntos-aleatorios lista)
  (let ((n (length lista)))
    (if (< n 2)
        9999999 ; Si hay menos de 2 puntos, devolvemos infinito (invalidez)
        (let ((i1 (random n))
              (i2 (random n)))
          (if (= i1 i2)
              (puntos-aleatorios lista) ; Asegurar que los índices sean diferentes
              (list (list-ref lista i1) (list-ref lista i2)))))))

; Función para calcular la delta inicial
(define (calcular-delta-inicial B1 B2)
  (let ((puntos-B1 (puntos-aleatorios B1)))
    (let ((puntos-B2 (puntos-aleatorios B2)))
      (let ((delta-B1 (if (equal? puntos-B1 9999999)
                          9999999
                          (distancia-euclidea (car puntos-B1) (cadr puntos-B1)))))
        (let ((delta-B2 (if (equal? puntos-B2 9999999)
                            9999999
                            (distancia-euclidea (car puntos-B2) (cadr puntos-B2)))))
          (min delta-B1 delta-B2))))))



; Función para buscar la distancia mínima entre puntos en dos bandas
(define (distancia-minima-bandas B1 B2 delta-inicial)
  (let bucle ((B1 B1)
             (B2 B2)
             (delta-min delta-inicial)
             (punto-min '())
             (i 0)
             (j 0))
    (if (>= i (length B1))
        (list delta-min punto-min) ; Devuelve la distancia mínima y los puntos correspondientes
        (let ((pi (list-ref B1 i)))
          (let ((j (let advance-j ((j j))
                     (if (and (< j (length B2))
                              (<= (cdr (list-ref B2 j)) (- (cdr pi) delta-min)))
                         (advance-j (+ j 1))
                         j))))
            (let ((k-limit (min 5 (- (length B2) j))))
              (let ((nueva-minima (let find-min ((k 0) (delta-min delta-min) (punto-min punto-min))
                                    (if (>= k k-limit)
                                        (list delta-min punto-min)
                                        (let ((pj (list-ref B2 (+ j k))))
                                          (let ((distancia (distancia-euclidea pi pj)))
                                            (if (< distancia delta-min)
                                                (find-min (+ k 1) distancia (list pi pj))
                                                (find-min (+ k 1) delta-min punto-min))))))))
                (bucle B1 B2 (car nueva-minima) (cadr nueva-minima) (+ i 1) j))))))))


; Función para dividir los puntos en dos listas manteniendo el orden
(define (dividir-puntos puntos)
  (let ((n (length puntos))) ; Calcula la longitud de puntos-ordenados
    (let ((punto-medio (list-ref puntos (quotient n 2)))) ; Toma el punto en la posición media
      (let ((x0 (car punto-medio)))  ; Coordenada x de la frontera

        ; Divide la lista en dos manteniendo el orden
        (let ((resultado (foldl (lambda (punto acc)
                                  (let ((P1 (car acc))
                                        (P2 (cdr acc)))
                                    (if (< (car punto) x0)
                                        (cons (cons punto P1) P2) ; Agrega a P1 manteniendo orden
                                        (cons P1 (cons punto P2))))) ; Agrega a P2 manteniendo orden
                                (cons '() '()) ; Inicializa las listas P1 y P2
                                puntos))) ; Recorre los puntos

          ; Extraemos las listas resultantes
          (let ((P1 (reverse (car resultado))) ; Invierte P1 para mantener el orden original
                (P2 (reverse (cdr resultado)))) ; Invierte P2 para mantener el orden original
            (list P1 P2)))))))

; Función principal para procesar el archivo y calcular la distancia mínima  
(define (procesar-archivo archivo)
  (let ((puntos (call-with-input-file archivo next-line-it)))
    (let ((bandas (dividir-puntos puntos)))
      (let ((B1 (car bandas)))
        (let ((B2 (cadr bandas)))
          (let ((delta-inicial (calcular-delta-inicial B1 B2)))
            (distancia-minima-bandas B1 B2 delta-inicial)))))))

; Ejemplo de uso
(procesar-archivo "ej_pts_01.txt")
