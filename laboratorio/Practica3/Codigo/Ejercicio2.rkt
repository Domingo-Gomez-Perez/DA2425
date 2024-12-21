#lang racket
; Leer fichero
(define (next-line-it file)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
      (cons line (next-line-it file))
      )))

(define (length s)
    (if (null? s)
        0
	(+ 1 (length (cdr s)))))

(define (devuelveLista lista) (
    if (void? lista)
       null
       (if (null? lista)
           lista
           (cons (cons (string->number (car (string-split (car lista) " "))) (string->number (car (cdr (string-split (car lista) " "))))) (devuelveLista (cdr lista)))
                                        )))

(define listaPtos (devuelveLista (call-with-input-file "ej_pts_europa.txt" next-line-it)))

; Calcula la distancia entre dos puntos (x1,y1) (x2,y2)
(define (calculaDistancia tuplaX tuplaY) (
    if (equal? tuplaX tuplaY)
       MAX
       (sqrt (+ (* (- (car tuplaX) (car tuplaY)) (- (car tuplaX) (car tuplaY))) (* (- (cdr tuplaX) (cdr tuplaY)) (- (cdr tuplaX) (cdr tuplaY)))))
                                          ))


; Constante necesaria para comparar y encontrar el mínimo.
(define MAX 999999999)



; Esta versión por fuerza bruta tiene una complejidad de O(n^2), pero se puede reducir a O((n^2-n)/2) recorriendo solo el triángulo superior de la matriz, excluyendo también la diagonal
; Para ello usaré la función reduce

(define (reduce operacion lista valorDefecto) (
    if (null? lista)
       valorDefecto
       (reduce operacion (cdr lista) (operacion valorDefecto (car lista)))
                                               ))

(define (mini x y) (
    if (< x y)
       x
       y
                   ))

(define (minimo lista) (
    reduce (lambda (x y) (mini x (minimo-j y lista))) lista MAX
                                   ))

(define (minimo-j elem lista) (
    reduce (lambda (x y) (mini x (calculaDistancia elem y))) lista MAX
                                   ))

(minimo listaPtos)