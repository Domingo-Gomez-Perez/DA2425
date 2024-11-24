#lang racket

; Calcula la distancia entre dos puntos
(define (euclidean-distance p1 p2)
  (sqrt (+ (sqr (- (first p1) (first p2)))
           (sqr (- (second p1) (second p2))))))

; Fase de preprocesado dee los datos iniciales
(define (preprocesa lista)
    (sort lista < #:key car))

; Pre: la lista se asume ordenada en orden no decreciente
(define (divide-lista lista)
    (define mid (quotient (length lista) 2))
    (define x0 (car (list-ref lista mid)))
    (let loop ((i 0) (p1 (list)) (p2 (list)))
        (if (= i (length lista))
            (list x0 p1 p2)
            (begin
                (if (< i mid)
                    (loop (+ i 1) (append p1 (list (list-ref lista i))) p2)
                    (loop (+ i 1) p1 (append p2 (list (list-ref lista i)))))))))

; Genera las particiones B1 y B2 a partir de P1 y P2, respectivamente
(define (sublista x0 stop p aux)
  (if (null? p)
        aux
        (let ((current (car (car p))))
            (if (< current x0)
                (if (> current stop)
                    p
                    (sublista x0 stop (cdr p) aux))
                (if (>= current stop)
                    aux
                    (let ((new-aux (append aux (list (car p)))))
                        (sublista x0 stop (cdr p) new-aux)))))))

; Función principal para B1 y B2
(define (combinar x0 min-p1 min-p2 p1 p2)
    (define delta-p1 (euclidean-distance (car min-p1) (cadr min-p1)))
    (define delta-p2 (euclidean-distance (car min-p2) (cadr min-p2)))
    (define delta (min delta-p1 delta-p2))
    (define min-p (if (eq? delta-p1 delta) min-p1 min-p2))
    (define stop1 (- x0 delta))
    (define b1 (sublista x0 stop1 p1 (list)))            
    (define stop2 (+ x0 delta))
    (define b2 (sublista x0 stop2 p2 (list)))
    (define min-b (min-dist-delta b1 b2 delta))
    (if (eq? (car min-b) #f) min-p min-b))

; Calcula los puntos más cercanos en B1 y B2 y comprueba si < delta
(define (min-dist-delta b1 b2 delta)
    (define mindist delta)
    (define closest-points '(#f #f))
    (for* ([p1 b1] [p2 b2])
        (define dist (euclidean-distance p1 p2))
        (when (< dist mindist)
            (set! mindist dist)
            (set! closest-points (list p1 p2))))
    closest-points)

; Calcula los puntos más cercanos en P1 y P2
(define (min-dist-brute lista)
    (let loop ((points lista)
                (mindist +inf.0)
                (min-points '()))
        (if (null? (cdr points))
            min-points
            (let* ((p1 (car points))
                (closest (foldl (lambda (p2 acc)
                                    (let* ((dist (euclidean-distance p1 p2))
                                            (current-min-dist (car acc))
                                            (current-points (cdr acc)))
                                    (if (< dist current-min-dist)
                                        (cons dist (list p1 p2))
                                        acc)))
                                (cons mindist min-points)
                                (cdr points))))
                (loop (cdr points) (car closest) (cdr closest))))))

; Función principal general
(define (min-dist lista)
    (define parts (divide-lista lista))
    (define x0 (car parts))
    (define p1 (cadr parts))
    (define p2 (caddr parts))
    (define min-p1 (min-dist-brute p1))
    (define min-p2 (min-dist-brute p2))
    (combinar x0 min-p1 min-p2 p1 p2))

; Función para leer todas las coordenadas y agregarlas a una lista.
(define (next-line-it file)
  (let loop ((line (read-line file 'any))
             (lista '()))
    (if (eof-object? line)
        (reverse lista)
        (let* ((lin (string-split line " "))
               (a (string->number (car lin)))
               (b (string->number (cadr lin)))
               (coord (list a b)))
          (loop (read-line file 'any) (cons coord lista))))))

; Ejecución
(call-with-input-file "./ej_pts_europa.txt" ; Termina para europa, 02 y 03; pero para 01 sigue siendo ineficiente
    (lambda (file)
        (define points (next-line-it file))
        (define ordenada (preprocesa points))
        (define mindist (min-dist ordenada))
        (displayln "Puntos más cercanos:")
        (displayln mindist)
        (displayln "Distancia mínima:")
        (displayln (euclidean-distance (car mindist) (cadr mindist)))))
