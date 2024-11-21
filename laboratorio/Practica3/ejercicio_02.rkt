#lang racket

(require math/statistics)

(define (next-line-it file)
  (let loop ((line (read-line file 'any))
             (points '()))
    (if (eof-object? line)
        (reverse points) ; Devuelve la lista de puntos al final de la lectura
        (let* ((values (string-split line " ")) ; Divide la línea en dos valores
               (x (string->number (first values))) ; Convierte el primer valor a número
               (y (string->number (second values))) ; Convierte el segundo valor a número
               (point (list x y))) ; Crea una lista con x e y
          (loop (read-line file 'any) (cons point points))))))


; Llamada para leer el archivo y almacenar los puntos
(define puntos
  (call-with-input-file "ej_pts_europa.txt" next-line-it))

(displayln puntos)


(define (square x) (* x x))

(define (distancia-euc list1 list2)
  (+ (square (- (car list1) (car list2))) (square (- (car (cdr list1)) (car (cdr list2))))))

(define (puntos-mas-cercanos-helper lista puntos-restantes punto1-min punto2-min dist-min)
  (cond
    ((null? puntos-restantes)
     (list punto1-min punto2-min))
    (else
     (let* ((punto (car puntos-restantes))
            (distancia (distancia-euc lista punto)))
       (if (< distancia dist-min)
           (puntos-mas-cercanos-helper lista (cdr puntos-restantes) lista punto distancia)
           (puntos-mas-cercanos-helper lista (cdr puntos-restantes) punto1-min punto2-min dist-min))))))

(define (puntos-mas-cercanos-rec lista puntos-minimos dist-min)
  (cond
    ((null? lista)
     puntos-minimos)
    (else
     (let ((resultado (puntos-mas-cercanos-helper (car lista) (cdr lista) (first puntos-minimos) (second puntos-minimos) dist-min)))
       (puntos-mas-cercanos-rec (cdr lista) resultado (distancia-euc (first resultado) (second resultado)))))))

(define (puntos-mas-cercanos lista)
  (if (or (null? lista) (null? (cdr lista)))
      '()
      (puntos-mas-cercanos-rec lista (list (car lista) (cadr lista)) (distancia-euc (car lista) (cadr lista)))))

; Prueba de la función
(define resultado (puntos-mas-cercanos puntos))
(displayln resultado)

