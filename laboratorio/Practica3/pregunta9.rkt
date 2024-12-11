#lang racket

; Calcula la distancia entre dos puntos
(define (euclidean-distance p1 p2)
  (sqrt (+ (sqr (- (first p1) (first p2)))
           (sqr (- (second p1) (second p2))))))

; Fase de preprocesado dee los datos iniciales
(define (preprocesa lista)
    (list (sort lista < #:key car) (sort lista < #:key cadr)))

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
(define (combinar x0 min-p1 min-p2 x1 x2 y1 y2)
    (define delta-p1 (euclidean-distance (car min-p1) (cadr min-p1)))
    (define delta-p2 (euclidean-distance (car min-p2) (cadr min-p2)))
    (define delta (min delta-p1 delta-p2))
    (define min-p (if (eq? delta-p1 delta) min-p1 min-p2))
    (define stop1 (- x0 delta))
    (define bx1 (sublista x0 stop1 x1 (list)))
    (define b1 (filter (lambda (e) (member e bx1)) y1))
    (define stop2 (+ x0 delta))
    (define bx2 (sublista x0 stop2 x2 (list)))
    (define b2 (filter (lambda (e) (member e bx2)) y2))
    (define min-b (min-dist-delta b1 b2 delta))
    (if (eq? (car min-b) #f) min-p min-b))

; Calcula los puntos más cercanos en B1 y B2 y comprueba si < delta
(define (min-dist-delta b1 b2 delta)
  (define mindist delta)
  (define closest-points '(#f #f))
  (let loop-i ((i 0) (j 0)) ; Bucle externo para iterar sobre b1
    (if (>= i (length b1)) ; Si ya hemos procesado todos los puntos de b1, terminamos
        closest-points
        (let* ((p1 (list-ref b1 i)) ; Punto actual de b1
               (new-j (let loop-j ((j j)) ; Bucle interno para ajustar j en b2
                        (if (or (>= j (length b2))
                                (> (cadr (list-ref b2 j)) (- (cadr p1) delta)))
                            j
                            (loop-j (add1 j))))) ; Incrementa j si la condición no se cumple
               (candidates (take (drop b2 new-j) (min 5 (- (length b2) new-j))))) ; Toma hasta 5 elementos desde b2[new-j]
          (for ([p2 candidates]) ; Itera sobre los candidatos en b2
            (define dist (euclidean-distance p1 p2))
            (when (< dist mindist) ; Si encontramos una distancia menor, actualizamos
              (set! mindist dist)
              (set! closest-points (list p1 p2))))
          (loop-i (add1 i) new-j))))) ; Incrementa i y pasa el nuevo valor de j

; Función principal general
; x e y representan la misma nube de puntos preprocesada
; - x con abscisa no decreciente
; - y con ordenada no decreciente
(define (min-dist x y)
    (if (<= (length x) 3)
        (cond ((= (length x) 2)(list (car x) (cadr x)))
            (else (let* ((p1 (car x))
                            (p2 (cadr x))
                            (p3 (caddr x))
                            (d12 (euclidean-distance p1 p2))
                            (d13 (euclidean-distance p1 p3))
                            (d23 (euclidean-distance p2 p3))
                            (mindist (min d12 d13 d23)))
                        (cond ((= mindist d12) (list p1 p2))
                            ((= mindist d13) (list p1 p3))
                            ((= mindist d23) (list p2 p3))))))
        (let*
            ((parts-x (divide-lista x))
                (x0 (car parts-x))
                (x1 (cadr parts-x))
                (x2 (caddr parts-x))
                (y1 (sort x1 < #:key cadr))
                (y2 (sort x2 < #:key cadr))
                (min-p1 (min-dist x1 y1))
                (min-p2 (min-dist x2 y2)))
            (combinar x0 min-p1 min-p2 x1 x2 y1 y2))))

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
(call-with-input-file "./ej_pts_01.txt" ; Termina para europa, 01, 02 y 03
    (lambda (file)
        (define points (next-line-it file))
        (define nubes (preprocesa points))
        (define mindist (min-dist (car nubes) (cadr nubes)))
        (displayln "Puntos más cercanos:")
        (displayln mindist)
        (displayln "Distancia mínima:")
        (displayln (euclidean-distance (car mindist) (cadr mindist)))))
