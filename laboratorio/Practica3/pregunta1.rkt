#lang racket
(require math/statistics)

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

; Busca el elemento i en la lista
(define (buscaElemento i lista) (
    buscaElemento-rec i lista 0
                                 ))

(define (buscaElemento-rec i lista cont) (
    if (= i cont)
       (car lista)
       (buscaElemento-rec i (cdr lista) (+ cont 1))
                                          ))
; Para encontrar el mínimo por fuerza bruta hay que comparar las distancias entre todos los puntos con todos
; los puntos, lo cual significa que hay que recorrer una matriz.

; min-i es el bucle exterior que recorre las filas de la matriz.
(define (min-i i lista minimo) (
    if (< i (length lista))
       (min-i (+ i 1) lista (min-j (buscaElemento i lista) lista minimo))
       minimo
                         ))

; min-j es el bucle interior que recorre las columnas de la matriz.
(define (min-j elem lista minimo) (
    if (null? lista)
       minimo
       (if (< (calculaDistancia elem (car lista)) minimo)
           (min-j elem (cdr lista) (calculaDistancia elem (car lista)))
           (min-j elem (cdr lista) minimo)
        )
                                   ))
; Función principal que busca el mínimo en una lista por fuerza bruta.
(define (min lista) (
    min-i 0 lista MAX
                     ))

; Constante necesaria para comparar y encontrar el mínimo.
(define MAX 999999999)

; Ejemplo
(displayln 'Ejemplo)
(min (list (cons 1 2) (cons 3 4) (cons 5 6) (cons 7 8) (cons 9 10)))
; Debería devolver 0, porque como compara todos los puntos con todos, también compara un punto con sigo mismo, y la distancia entre dos puntos iguales es 0. Pero como eso no sería
; correcto, está arreglado.

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

; Ejemplo
(minimo (list (cons 1 2) (cons 3 4) (cons 5 6) (cons 7 8) (cons 9 10)))
(displayln 'Solución)
(min listaPtos)
(minimo listaPtos)