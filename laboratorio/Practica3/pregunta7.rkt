#lang racket

(require math/statistics) ; Librería opcional para cálculos avanzados

;7) Resuelve (5) bajo el supuesto añadido de que los puntos de la lista de entrada están ordenados
;con abscisa no decreciente, y con el requisito adicional de mantener esta propiedad en las listas
;de salida.

; Función para dividir puntos ordenados en dos sublistas balanceadas
(define (dividir-puntos-ordenados puntos delta)
  (let* ([n (length puntos)]
         [mitad (quotient n 2)]
         [x0 (car (list-ref puntos mitad))] ; Coordenada x del pivote
         [P1 (filter (lambda (punto) (<= (car punto) x0)) puntos)] ; Puntos izquierda
         [P2 (filter (lambda (punto) (> (car punto) x0)) puntos)]) ; Puntos derecha
    (list P1 P2 x0 delta))) ; Retorna las sublistas, el pivote y delta

; Función para limitar la búsqueda a las bandas B1 y B2
(define (limitar-bandas puntos x0 delta)
  (filter (lambda (punto)
            (and (>= (car punto) (- x0 delta)) (<= (car punto) (+ x0 delta))))
          puntos))

; Función principal para manejar la partición y combinación
(define (resolver-puntos puntos delta)
  (let* ([particion (dividir-puntos-ordenados puntos delta)]
         [P1 (car particion)]
         [P2 (cadr particion)]
         [x0 (caddr particion)]
         [B1 (limitar-bandas P1 x0 delta)]
         [B2 (limitar-bandas P2 x0 delta)])
    (list P1 P2 B1 B2 x0))) ; Retorna las sublistas y bandas

; Prueba con un conjunto de puntos ordenados
(define puntos-prueba '((1 2) (3 4) (5 6) (7 8) (9 10)))
(define delta 2) ; Valor delta para limitar las bandas
(define resultado (resolver-puntos puntos-prueba delta))

; Mostrar resultados
(displayln "P1: ") (displayln (car resultado))
(displayln "P2: ") (displayln (cadr resultado))
(displayln "B1: ") (displayln (caddr resultado))
(displayln "B2: ") (displayln (cadddr resultado))
(displayln "x0: ") (displayln (car (cddddr resultado)))

; ---------------------------------------
; Complejidad del algoritmo
; ---------------------------------------
; Temporal:
; - División en sublistas: O(n), ya que los puntos están previamente ordenados.
; - Búsqueda limitada en bandas: O(n).
; - Complejidad total: O(n log n), dominada por la fase de combinación.
;
; Espacial:
; - Sublistas P1, P2, y las bandas B1, B2 ocupan O(n) espacio.
; - Complejidad espacial total: O(n).
; ---------------------------------------
