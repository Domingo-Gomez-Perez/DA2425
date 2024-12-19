#lang racket

; Función para dividir una lista de puntos en dos subconjuntos P1 y P2
(define (dividir-puntos puntos)
  (define (primeros-n lista n)
    (if (or (= n 0) (null? lista))
        '()
        (cons (car lista) (primeros-n (cdr lista) (- n 1)))))

  (define (ultimos-n lista n)
    (if (null? lista)
        '()
        (if (<= (length lista) n)
            lista
            (ultimos-n (cdr lista) n))))

  (let* ([puntos-ordenados (sort puntos
                                 (lambda (p1 p2)
                                   (< (car p1) (car p2))))] ; Ordenar los puntos por su coordenada x
         [n (length puntos-ordenados)]
         [mitad (quotient n 2)]
         [P1 (primeros-n puntos-ordenados mitad)]
         [P2 (cdr (drop puntos-ordenados mitad))]
         [x0 (car (last P1))])
    (list x0 P1 P2)))

; Función que convierte las líneas de un archivo en una lista de puntos
(define (lines-to-list file)
  (define (lines-to-list-iter file lista)
    (let ([linea (read-line file 'any)])
      (if (eof-object? linea)
          lista
          (lines-to-list-iter file (cons (formatear-linea linea) lista)))))
  (reverse (lines-to-list-iter file '())))

; Función para formatear cada línea y convertirla en un punto (par de coordenadas)
(define (formatear-linea linea)
  (let* ([values (string-split linea " ")]
         [x (string->number (first values))]
         [y (string->number (second values))])
    (list x y)))

; Calcula el cuadrado de la distancia euclidiana entre dos puntos
(define (square x)
  (* x x))

; son tuplas de 2 elementos (x,y)
(define (distancia-euclidiana list1 list2)
  (+ (square (- (car list1) (car list2))) (square (- (cadr list1) (cadr list2)))))

; Genera las particiones cercanas al corte
(define (generar-particiones corte rango-min rango-max lista acumulador)
  (if (null? lista)
      acumulador
      (let ([x-actual (car (car lista))])
        (if (< x-actual corte)
            (if (> x-actual rango-min)
                (generar-particiones corte rango-min rango-max (cdr lista) acumulador)
                acumulador)
            (if (< x-actual rango-max)
                (generar-particiones corte
                                     rango-min
                                     rango-max
                                     (cdr lista)
                                     (cons (car lista) acumulador))
                acumulador)))))

; Combina las listas cercanas al corte para encontrar los puntos más cercanos
(define (combinar-puntos corte puntos-izq-min puntos-der-min lista-izq lista-der)
  (define distancia-izq (sqrt (distancia-euclidiana (car puntos-izq-min) (cadr puntos-izq-min))))
  (define distancia-der (sqrt (distancia-euclidiana (car puntos-der-min) (cadr puntos-der-min))))
  (define distancia-minima (min distancia-izq distancia-der))
  (define puntos-mas-cercanos (if (= distancia-minima distancia-izq) puntos-izq-min puntos-der-min))
  (define rango-izq (- corte distancia-minima))
  (define lista-cercana-izq (generar-particiones corte rango-izq corte lista-izq '()))
  (define rango-der (+ corte distancia-minima))
  (define lista-cercana-der (generar-particiones corte corte rango-der lista-der '()))
  (define puntos-corte-min
    (buscar-puntos-cercanos lista-cercana-izq lista-cercana-der distancia-minima))
  (if (null? puntos-corte-min) puntos-mas-cercanos puntos-corte-min))

; Busca los puntos más cercanos entre dos listas
(define (buscar-puntos-cercanos b1 b2 distancia-limite)
  (let loop ([b1 b1]
             [distancia-actual distancia-limite]
             [puntos-mas-cercanos '()])
    (if (null? b1)
        puntos-mas-cercanos
        (let* ([punto1 (car b1)]
               [mejor (foldl (lambda (punto2 mejor-actual)
                               (let ([dist (sqrt (distancia-euclidiana punto1 punto2))])
                                 (if (< dist distancia-actual)
                                     (list dist (list punto1 punto2))
                                     mejor-actual)))
                             (list distancia-actual puntos-mas-cercanos)
                             b2)])
          (loop (cdr b1) (car mejor) (cadr mejor))))))

; Calcula los puntos más cercanos en una lista
(define (distancia-minima-2 lista)
  (let loop ([puntos lista]
             [distancia-minima +inf.0]
             [puntos-minimos '()])
    (if (null? (cdr puntos))
        puntos-minimos
        (let* ([punto1 (car puntos)]
               [mejor (foldl (lambda (punto2 mejor-actual)
                               (let ([dist (distancia-euclidiana punto1 punto2)])
                                 (if (< dist (car mejor-actual))
                                     (cons dist (list punto1 punto2))
                                     mejor-actual)))
                             (cons distancia-minima puntos-minimos)
                             (cdr puntos))])
          (loop (cdr puntos) (car mejor) (cdr mejor))))))

; Función principal dividida por partes:
(define (distancia-minima puntos)
  (define particiones (dividir-puntos puntos))
  (define x0 (car particiones))
  (define lista-izq (cadr particiones))
  (define lista-der (caddr particiones))
  (define puntos-izq-min (distancia-minima-2 lista-izq))
  (define puntos-der-min (distancia-minima-2 lista-der))
  (combinar-puntos x0 puntos-izq-min puntos-der-min lista-izq lista-der))

; Ejecución
(call-with-input-file "./ej_pts_europa.txt"
                      (lambda (archivo)
                        (define puntos (lines-to-list archivo))
                        (define resultado (distancia-minima puntos))
                        (displayln "Puntos más cercanos encontrados:")
                        (displayln resultado)
                        (displayln "Distancia mínima entre esos puntos:")
                        (displayln (sqrt (distancia-euclidiana (car resultado) (cadr resultado))))))
