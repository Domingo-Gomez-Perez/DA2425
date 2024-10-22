#lang racket
(require math/statistics)
;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Pregunta 01 ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
; Viena <-> Bratislava 


;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Pregunta 02 ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
(define (euclidean-distance p1 p2)
  (sqrt (+ (sqr (- (first p1) (first p2)))
           (sqr (- (second p1) (second p2))))))

(define (closest-pair points)
  (define min-dist +inf.0)
  (define closest '())

  (for* ([i (in-range (length points))]
         [j (in-range (+ i 1) (length points))])
    (let ([p1 (list-ref points i)]
          [p2 (list-ref points j)]
          [dist (euclidean-distance (list-ref points i) (list-ref points j))])
      (when (< dist min-dist)
        (set! min-dist dist)
        (set! closest (list p1 p2)))))
  
  (list closest min-dist))

;; Function to read points from a file
(define (next-line-it file)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
      (let* ([splitted (string-split line " ")]
             [x (string->number (car splitted))]
             [y (string->number (cadr splitted))]
             [point (list x y)])
        (set! points (cons point points)))
      (next-line-it file))))

;; Function to read all points from a file and return the list of points
(define (read-points filename)
  (set! points '())  ;; Clear the points list before reading
  (call-with-input-file filename next-line-it)
  (reverse points))  ;; Return the points in the original order

(call-with-input-file "ej_pts_01.txt" next-line-it)

;; Función principal que ejecuta la solución
(define (main filename)
  (let ([points (read-points filename)])
    (let ([result (closest-pair points)])
      (printf "Los puntos más cercanos son: ~a con una distancia de ~a\n" 
              (first result) (second result)))))

;; Cambiar aquí el nombre del fichero con los puntos
(main "ej_pts_01.txt")
