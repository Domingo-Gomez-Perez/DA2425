#lang racket

(require math/statistics) ; Para funciones matemáticas si se necesitan

; Función para leer el archivo de puntos, donde cada línea contiene coordenadas separadas por espacios
(define (leer-puntos file-name)
  (call-with-input-file file-name
    (lambda (file)
      (let loop ((line (read-line file)) (points '()))
        (if (eof-object? line)
            points ; retornar los puntos una vez que se haya leído todo el archivo
            (loop (read-line file 'any)
                  (cons (map string->number (string-split line " ")) points)))))))

; Función para calcular la distancia euclidiana entre dos puntos en el plano
(define (distancia p1 p2)
  (sqrt (+ (sqr (- (first p1) (first p2))) ; Diferencia en x
           (sqr (- (second p1) (second p2)))))) ; Diferencia en y


(define (reverseaux lista resultado)
    (if (null? (cdr lista)) (cons (car lista) resultado) ;Si no hay mas elementos
        (reverseaux (cdr lista) (cons (car lista) resultado))));Si hay mas elementos quito de la lista el primer elemento y lo añado al final del resultado

;inicializo el resultado a null
(define (reverse lista) (reverseaux lista null))
; Función principal que calcula la distancia mínima entre los puntos
(define (distancia-minima2 puntos)
  (define (buscar-minima i j min-dist ciudad1 ciudad2 restantesi restantesj)
    (if (< j (length puntos))
        
        (let ([dist (distancia (car restantesi) (car restantesj))])
          ;(display dist) (display " ")(display i)(display " ")(display j)(display " ")(display (obj puntos i)) (display " ")(display (obj puntos j))
          ;(newline)
          (if (< dist min-dist)
              (buscar-minima i (+ j 1) dist i j restantesi (cdr restantesj)) ; Actualiza la distancia y las ciudades
              (buscar-minima i (+ j 1) min-dist ciudad1 ciudad2 restantesi (cdr restantesj))))
        (if (< i (- (length puntos) 1))
            (buscar-minima (+ i 1) (+ i 2) min-dist ciudad1 ciudad2 (cdr restantesi)(cddr restantesi)) ; Avanza al siguiente punto
            (list min-dist ciudad1 ciudad2)))) ; Retorna el resultado final

  (buscar-minima 0 1 9999999 -1 -1 puntos (cdr puntos))) ; Llama a la función recursiva con los valores iniciales

(display "Escribe el nombre del archivo: (ejemplo: ej_pts_02.txt) ")
 (define file (read-line))
; Script principal que ahora recibe el archivo como parámetro
(define (main file)
  (define puntos (leer-puntos file)) ; Leemos los puntos del archivo
  (define puntos2 (reverse puntos))
  (define lista (distancia-minima2 puntos2)) ; Calculamos la distancia mínima
  (define min-dist (car lista))
  (define ciudad1 (car (cdr lista)))
  (define ciudad2 (car (cddr lista)))
  (printf "La distancia mínima es ~a entre las ciudades ~a y ~a\n" min-dist ciudad1 ciudad2)) ; Mostramos el resultado

(main file)


