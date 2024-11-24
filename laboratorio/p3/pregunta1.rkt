#lang racket
(require math/statistics)

; Función para leer todas las coordenadas y agregarlas a una lista.
(define (next-line-it file)
  (let loop ((line (read-line file 'any))
             (agenda '())) ; Iniciamos la agenda como una lista vacía
    (if (eof-object? line)
        (reverse agenda) ; Al final, devolvemos la lista con las coordenadas en orden
        (let* ((lin (string-split line " "))
               (a (string->number (car lin)))
               (b (string->number (cadr lin)))
               (coord (list a b)))
          (loop (read-line file 'any) (cons coord agenda)))))) ; Agregamos la coordenada a la agenda

(define (euclidean-distance p1 p2)
  (sqrt (+ (sqr (- (first p1) (first p2)))
           (sqr (- (second p1) (second p2))))))

; Calcula la distancia mínima entre todos los puntos de una lista de coordenadas.
(define (min-dist agenda)
  (let loop ((points agenda)
             (min-dist +inf.0)) ; Inicializamos la distancia mínima con +inf.0
    (if (null? (cdr points)) ; Si solo queda un punto o ninguno, hemos terminado
        min-dist
        (let* ((p1 (car points))
               (dists (map (lambda (p2) (euclidean-distance p1 p2)) (cdr points))) ; Calcula las distancias desde p1 a todos los demás puntos
               (new-min (apply min (cons min-dist dists)))) ; Encuentra la mínima distancia en este ciclo
          (loop (cdr points) new-min))))) ; Llama recursivamente, excluyendo el primer punto de la lista

; LLamada a la función
(call-with-input-file "./ej_pts_europa.txt"
  (lambda (file)
    (define points (next-line-it file)) ; Lee los puntos del archivo
    (displayln "Puntos leídos:")
    (displayln points)
    (define mindist (min-dist points)) ; Calcula la distancia mínima
    (displayln "Distancia mínima:")
    (displayln mindist)))
