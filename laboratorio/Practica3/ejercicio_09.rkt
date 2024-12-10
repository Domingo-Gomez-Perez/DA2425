#lang racket
; Convertir líneas del archivo en una lista de puntos
; Complejidad O(n), donde n es el número de líneas en el archivo
; recorriéndolas una vez
(define (lines-to-list file)
  (define (lines-to-list-iter file lista)
    (let ([linea (read-line file 'any)])
      (if (eof-object? linea)
          lista
          (lines-to-list-iter file (cons (formatear-linea linea) lista)))))
  (reverse (lines-to-list-iter file '())))

; Convertir una línea en un punto (par de coordenadas)
; Complejidad O(nlogn), donde n es el número de puntos que se ordenan
; por x e y
(define (formatear-linea linea)
  (let* ([values (string-split linea " ")]
         [x (string->number (first values))]
         [y (string->number (second values))])
    (list x y)))

; Preprocesa listas ordenadas
; Complejidad O(nlogn), donde n es el numero de puntos que se pasan como parámetro
(define (preprocesar puntos)
  (let ([ordenado-x (sort puntos (lambda (p1 p2) (< (car p1) (car p2))))]
        [ordenado-y (sort puntos (lambda (p1 p2) (< (cadr p1) (cadr p2))))])
    (list ordenado-x ordenado-y)))

; Divide listas ordenadas en dos partes P1 y P2
; Complejidad O(n), donde n es el número total de puntos en la lista
; ordenado-x o ordenado-y
(define (dividir-puntos ordenado-x ordenado-y)
  (let* ([n (length ordenado-x)]
         [mitad (quotient n 2)]
         [P1x (take ordenado-x mitad)]
         [P2x (drop ordenado-x mitad)]
         [x0 (car (last P1x))]
         [P1y (filter (lambda (p) (<= (car p) x0)) ordenado-y)]
         [P2y (filter (lambda (p) (> (car p) x0)) ordenado-y)])
    (list x0 P1y P2y)))

; Calcula el cuadrado de un número
; Complejidad: O(1)
(define (square x)
  (* x x))

; Calcula la distancia euclidiana al cuadrado entre dos puntos
; Complejidad: O(1)
(define (distancia-euclidiana list1 list2)
  (+ (square (- (car list1) (car list2))) (square (- (cadr list1) (cadr list2)))))

; Genera particiones cercanas al corte x0 dentro de un rango
; Complejidad: O(n), donde n son los elementos de la lista ordenado-y ya que se van
; filtrando los puntos recorriéndola.
(define (generar-particiones ordenado-y x0 rango)
  (filter (lambda (p) (and (>= (car p) (- x0 rango)) (<= (car p) (+ x0 rango)))) ordenado-y))

; Combina puntos en las particiones cercanas al corte x0
; Complejidad: O(n), donde n es el número de puntos en las particiones
(define (combinar-puntos particiones x0)
  (let loop ([lista particiones]
             [puntos-mas-cercanos '()]
             [distancia-min x0])
    (if (null? lista)
        puntos-mas-cercanos
        (let* ([punto1 (car lista)]
               [siguientes (take (cdr lista)
                                 (min 6
                                      (length (cdr lista))))] ;; Evitar exceder el tamaño de la lista
               [mejor (foldl (lambda (punto2 mejor-actual)
                               (let ([dist (sqrt (distancia-euclidiana punto1 punto2))])
                                 (if (< dist distancia-min) dist mejor-actual)))
                             distancia-min
                             siguientes)])
          (loop (cdr lista)
                (if (< mejor distancia-min)
                    (list punto1 (car siguientes))
                    puntos-mas-cercanos)
                (min distancia-min mejor))))))

; Fuerza bruta para encontrar la distancia mínima en listas pequeñas
; Complejidad: O(n^2), donde n es el tamaño de la lista (menor a 4), es cuadrática
; pero como su uso esta limitado a casos pequeños no impacta en la complejidad total del algoritmo
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
; Complejidad: O(nlogn), puesto que hay O(logn) niveles de recursión y cada nivel es O(n)
(define (distancia-minima-rec ordenado-x ordenado-y)
  (let ([n (length ordenado-x)])
    (if (< n 4)
        ;; Resolver con fuerza bruta si el número de puntos es pequeño
        (buscar-puntos-cercanos ordenado-x)
        (let* ([particiones (dividir-puntos ordenado-x ordenado-y)]
               [x0 (car particiones)]
               [P1 (cadr particiones)]
               [P2 (caddr particiones)]
               [puntos-izq-min (distancia-minima-rec (take ordenado-x (quotient n 2)) P1)]
               [puntos-der-min (distancia-minima-rec (drop ordenado-x (quotient n 2)) P2)]
               [rango (min (sqrt (distancia-euclidiana (car puntos-izq-min) (cadr puntos-izq-min)))
                           (sqrt (distancia-euclidiana (car puntos-der-min) (cadr puntos-der-min))))]
               [particiones (generar-particiones ordenado-y x0 rango)]
               [puntos-corte-min (combinar-puntos particiones rango)])
          (if (null? puntos-corte-min)
              (if (< (sqrt (distancia-euclidiana (car puntos-izq-min) (cadr puntos-izq-min)))
                     (sqrt (distancia-euclidiana (car puntos-der-min) (cadr puntos-der-min))))
                  puntos-izq-min
                  puntos-der-min)
              puntos-corte-min)))))

; Función principal que preprocesa los puntos y llama a la recursión
; Complejidad: O(nlogn)
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
