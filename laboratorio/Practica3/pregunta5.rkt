#lang racket

(require math/statistics) ;

 ;5) Escribe una función que, tomando como argumento una lista de puntos, la divida en dos partes
 ;(llamémoslas P1 y P2) que satisfagan:
 ;|P1| − |P2| ≤ 1 y
 ;∃x0 ∈Q tal que todo punto (x, y) de P1 cumple x ≤ x0 y todo punto (x, y) de P2 cumple
 ;x ≥x0.
 ;Escribe tu respuesta en un fichero pregunta5.rkt. ¿Qué complejidad temporal y espacial representa
 ;tu función? Utilizar la función sort


; Función para dividir la lista de puntos
(define (dividir-puntos puntos)
  (let* ([ordenados (sort puntos (lambda (p1 p2) (< (car p1) (car p2))))] ; Ordenar por x
         [n (length puntos)]
         [mitad (quotient n 2)] ; Calcular la posición media
         [x0 (car (list-ref ordenados mitad))] ; Coordenada x de la mediana
         [P1 (filter (lambda (punto) (<= (car punto) x0)) ordenados)] ; Puntos con x <= x0
         [P2 (filter (lambda (punto) (> (car punto) x0)) ordenados)]) ; Puntos con x > x0
    (list P1 P2 x0))) ; Retorna las sublistas y el pivote

; Prueba de la función con una lista de ejemplo
(define puntos '((1 2) (3 4) (5 6) (7 8) (9 10)))
(define resultado (dividir-puntos puntos))
;Da x0 = 5 asi que cumle la funcionalidad esperada


; Mostrar resultados
(display "Sublista P1: ") (display (car resultado)) (newline)
(display "Sublista P2: ") (display (cadr resultado)) (newline)
(display "Valor x0: ") (display (caddr resultado)) (newline)

; ---------------------------------------
; Complejidad temporal y espacial
; ---------------------------------------
; Temporal:
; - La ordenación inicial tiene una complejidad de O(n log n), donde n es 
;   el número de puntos.
; - Filtrar los puntos en P1 y P2 toma O(n).
; - Complejidad total: O(n log n).
;
; Espacial:
; - Se crean nuevas sublistas P1 y P2 que ocupan un espacio total de O(n).
; - Complejidad espacial total: O(n).
; ---------------------------------------
