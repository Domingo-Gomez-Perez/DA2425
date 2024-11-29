#lang racket

(require math/statistics)

; Función para calcular la distancia al cuadrado entre dos puntos
(define (distancia-cuadrada p1 p2)
  (+ (sqr (- (car p2) (car p1))) (sqr (- (cadr p2) (cadr p1)))))

;Función para dividir puntos y calcular distancia mínima
(define (distancia-minima puntos)
  (define len (length puntos))
  
  ;Función auxiliar recursiva
  (define (distancia-minima-rec puntos)
    (define n (length puntos))
    
    ;Caso base: si hay pocos puntos, calcula distancia mínima directamente
    (if (<= n 3)
        (let loop ((i 0) (min-dist +inf.0))
          (if (>= i (- n 1))
              min-dist
              (let loop-inner ((j (+ i 1)) (current-min min-dist))
                (if (>= j n)
                    (loop (+ i 1) current-min)
                    (loop-inner (+ j 1) (min current-min (distancia-cuadrada (list-ref puntos i) (list-ref puntos j))))))))
        
        ; Caso recursivo: dividir puntos y comparar distancias
        (let* ((mitad (quotient n 2))
               (P1 (take puntos mitad))
               (P2 (drop puntos mitad))
               (distancia-P1 (distancia-minima-rec P1))
               (distancia-P2 (distancia-minima-rec P2))
               (delta (min distancia-P1 distancia-P2))
               (x0 (car (list-ref puntos mitad))))
          
          ; Seleccionar puntos cercanos a la línea divisoria
          (define puntos-en-banda
            (filter (lambda (p) (<= (abs (- (car p) x0)) delta)) puntos))
          
          ; Calcular la distancia mínima en la banda
          (define banda-len (length puntos-en-banda))
          (let loop ((i 0) (min-dist delta))
            (if (>= i (- banda-len 1))
                min-dist
                (let loop-inner ((j (+ i 1)) (current-min min-dist))
                  (if (or (>= j banda-len) (> (- (cadr (list-ref puntos-en-banda j)) (cadr (list-ref puntos-en-banda i))) delta))
                      (loop (+ i 1) current-min)
                      (loop-inner (+ j 1) (min current-min (distancia-cuadrada (list-ref puntos-en-banda i) (list-ref puntos-en-banda j)))))))))))
  
  ; Iniciar el cálculo de distancia mínima recursivamente
  (distancia-minima-rec puntos))

;Función para leer puntos desde un archivo
(define (leer-puntos-desde-archivo filename)
  (define puntos '())
  (define (procesar-linea file)
    (let ((line (read-line file 'any)))
      (unless (eof-object? line)
        (let ((coords (map string->number (string-split line " "))))
          (set! puntos (cons coords puntos)))
        (procesar-linea file))))
  (call-with-input-file filename procesar-linea)
  puntos)

;Uso con archivo de puntos
(define puntos (leer-puntos-desde-archivo "ej_pts_europa.txt"))
(displayln (sqrt (distancia-minima puntos)))