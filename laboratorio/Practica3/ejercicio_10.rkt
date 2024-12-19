#lang racket

; Convertir líneas del archivo en una lista de puntos
; Complejidad: O(n), donde n es el número de líneas en el archivo
(define (lines-to-list file)
  (define (lines-to-list-iter file lista)
    (let ([linea (read-line file 'any)])
      (if (eof-object? linea)
          lista
          (lines-to-list-iter file (cons (formatear-linea linea) lista)))))
  (reverse (lines-to-list-iter file '())))

; Convertir una línea en un punto (par de coordenadas)
; Complejidad: O(1)
(define (formatear-linea linea)
  (let* ([values (string-split linea " ")]
         [x (string->number (first values))]
         [y (string->number (second values))])
    (list x y)))

; Preprocesa listas ordenadas
; Complejidad: O(n log n), donde n es el número de puntos
(define (preprocesar puntos)
  (let ([ordenado-x (sort puntos (lambda (p1 p2) (< (car p1) (car p2))))]
        [ordenado-y (sort puntos (lambda (p1 p2) (< (cadr p1) (cadr p2))))])
    (list ordenado-x ordenado-y)))

; Calcula el cuadrado de un número
; Complejidad: O(1)
(define (square x)
  (* x x))

; Calcula la distancia euclidiana al cuadrado entre dos puntos
; Complejidad: O(1)
(define (distancia-euclidiana list1 list2)
  (+ (square (- (car list1) (car list2))) (square (- (cadr list1) (cadr list2)))))

; Fuerza bruta para encontrar la distancia mínima en listas pequeñas
; Complejidad: O(n^2), pero limitado a casos con menos de 4 puntos
(define (buscar-puntos-cercanos lista)
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

; Recursión del algoritmo divide y vencerás
; Complejidad: O(n log n)
(define (distancia-minima-rec ordenado-x ordenado-y)
  (let ([n (length ordenado-x)])
    (if (< n 4)
        ;; Caso base: Resolver con fuerza bruta
        (buscar-puntos-cercanos ordenado-x)
        (let* ([mitad (quotient n 2)]
               [P1x (take ordenado-x mitad)]
               [P2x (drop ordenado-x mitad)]
               [x0 (car (last P1x))]
               ;; Recursión en ambas mitades
               [puntos-izq-min
                (distancia-minima-rec P1x (filter (lambda (p) (<= (car p) x0)) ordenado-y))]
               [puntos-der-min (distancia-minima-rec P2x
                                                     (filter (lambda (p) (> (car p) x0)) ordenado-y))]
               ;; Distancia mínima encontrada hasta ahora
               [rango (min (sqrt (distancia-euclidiana (car puntos-izq-min) (cadr puntos-izq-min)))
                           (sqrt (distancia-euclidiana (car puntos-der-min) (cadr puntos-der-min))))])
          ;; Combinar puntos de ambas bandas en una lista ordenada por y
          (let ([Y-prima (filter (lambda (p) (<= (abs (- (car p) x0)) rango)) ordenado-y)])
            ;; Buscar la distancia mínima en Y' recorriendo los 5 siguientes
            (let loop ([lista Y-prima]
                       [distancia-min rango]
                       [puntos-mas-cercanos
                        (if (<
                             (sqrt (distancia-euclidiana (car puntos-izq-min) (cadr puntos-izq-min)))
                             (sqrt (distancia-euclidiana (car puntos-der-min) (cadr puntos-der-min))))
                            puntos-izq-min
                            puntos-der-min)])
              (if (null? lista)
                  puntos-mas-cercanos
                  (let* ([punto1 (car lista)]
                         [siguientes (take (cdr lista) (min 5 (length (cdr lista))))]
                         [mejor (foldl (lambda (punto2 mejor-actual)
                                         (let ([dist (distancia-euclidiana punto1 punto2)])
                                           (if (< dist (car mejor-actual))
                                               (cons dist (list punto1 punto2))
                                               mejor-actual)))
                                       (cons distancia-min puntos-mas-cercanos)
                                       siguientes)])
                    (loop (cdr lista) (car mejor) (cdr mejor))))))))))

; Función principal que preprocesa los puntos y llama a la recursión
; Complejidad: O(n log n)
(define (distancia-minima puntos)
  (let* ([preproceso (preprocesar puntos)]
         [ordenado-x (car preproceso)]
         [ordenado-y (cadr preproceso)])
    (distancia-minima-rec ordenado-x ordenado-y)))

; Leer puntos desde un archivo y calcular la pareja más cercana
(call-with-input-file "./ej_pts_europa.txt"
                      (lambda (archivo)
                        (define puntos (lines-to-list archivo))
                        (define resultado (distancia-minima puntos))
                        (displayln "Puntos más cercanos encontrados:")
                        (displayln resultado)
                        (displayln "Distancia mínima entre esos puntos:")
                        (displayln (sqrt (distancia-euclidiana (car resultado) (cadr resultado))))))
