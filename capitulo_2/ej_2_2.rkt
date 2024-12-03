#lang racket
; Constructor para crear un punto a partir de dos cordenadas
(define (make-point x y)
  (cons x y))

; Selector para obtener la coordenada x del punto
(define (x-point p)
  (car p))

; Selector para obtener la coordenada y del punto
(define (y-point p)
  (cdr p))

; Constructor para crear un segmento de línea a partir de dos puntos
(define (make-segment ini fin)
  (cons ini fin))

; Selector para obtener el punto de inicio del segmento
(define (start-segment s)
  (car s))

; Selector para obtener el punto de fin del segmento
(define (end-segment s)
  (cdr s))

; Procedimiento para calcular el punto medio de un segmento
(define (midpoint-segment s)
  (let ((ini (start-segment s))
        (fin (end-segment s)))
    (make-point
      (/ (+ (x-point ini) (x-point fin)) 2)  ; Promedio de las coordenadas x
      (/ (+ (y-point ini) (y-point fin)) 2))))  ; Promedio de las coordenadas y


(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


; Ejemplo de uso

; Crear dos puntos
(define p1 (make-point 0 0))
(define p2 (make-point 4 4))

; Crear un segmento usando esos puntos
(define segment (make-segment p1 p2))

; Calcular el punto medio del segmento
(define midpoint (midpoint-segment segment))

; Imprimir el punto medio
(print-point midpoint)

