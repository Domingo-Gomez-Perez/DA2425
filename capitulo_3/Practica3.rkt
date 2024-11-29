#lang racket

; Función para leer el archivo de puntos
(define (leer-puntos archivo)
  (with-input-from-file archivo
    (lambda ()
      (map string->number (port->list read)))))

; Función que calcula la distancia euclidiana entre dos puntos en el plano
(define (distancia-euclidiana p1 p2)
  (let* ((x1 (car p1))
         (y1 (cadr p1))
         (x2 (car p2))
         (y2 (cadr p2)))
    (sqrt (+ (sqr (- x1 x2)) (sqr (- y1 y2))))))

; Función que calcula el cuadrado de un número
(define (sqr x)
  (* x x))

; Función que calcula los dos puntos más cercanos utilizando fuerza bruta
(define (puntos-mas-cercanos puntos)
  (let loop ((puntos puntos)
             (mejor-distancia +inf.0)
             (mejor-par '()))
    (if (null? puntos)
        mejor-par
        (let* ((punto (car puntos))
               (resto (cdr puntos))
               (mejor (loop resto mejor-distancia mejor-par)))
          (foldl
           (lambda (otro-punto mejor-actual)
             (let ((dist (distancia-euclidiana punto otro-punto)))
               (if (< dist (car mejor-actual))
                   (list dist (list punto otro-punto))
                   mejor-actual)))
           mejor
           resto)))))

; Función principal que lee los puntos de un archivo y encuentra el par más cercano
(define (resolver archivo)
  (let* ((lista-planar (leer-puntos archivo)) ; Leer los puntos desde el archivo
         (puntos (partition 2 lista-planar))) ; Particionar la lista en pares de coordenadas (x, y)
    (if (< (length puntos) 2)
        (printf "Se necesitan al menos dos puntos para calcular la distancia\n")
        (let ((resultado (puntos-mas-cercanos puntos)))
          (if (null? resultado)
              (printf "No se encontraron pares de puntos\n")
              (printf "Los puntos más cercanos son ~a y ~a con una distancia de ~a\n"
                      (car (cdr resultado)) (cadr (cdr resultado)) (car resultado)))))))

; Función para particionar una lista en pares
(define (partition n lista)
  (if (or (null? lista) (< (length lista) n)) ; Asegurarse de que la lista no esté vacía
      '()
      (cons (take lista n) (partition n (drop lista n)))))

; Función para tomar los primeros n elementos de una lista
(define (take lista n)
  (if (or (null? lista) (zero? n)) ; Verificar si la lista está vacía o n es 0
      '()
      (cons (car lista) (take (cdr lista) (- n 1)))))

; Función para descartar los primeros n elementos de una lista
(define (drop lista n)
  (if (or (null? lista) (zero? n)) ; Verificar si la lista está vacía o n es 0
      lista
      (drop (cdr lista) (- n 1))))


(resolver "ej_pts_01")
