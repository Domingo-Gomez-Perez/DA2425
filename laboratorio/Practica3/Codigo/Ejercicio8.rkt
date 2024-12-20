#lang racket

; Función imprescindible
(define (reduce operacion lista valorDefecto) (
    if (null? lista)
       valorDefecto
       (reduce operacion (cdr lista) (operacion valorDefecto (car lista)))
                                               ))

; Constante necesaria
(define MAX 999999999)

; Función que calcula la distancia entre dos puntos
(define (calculaDistancia tuplaX tuplaY) (
    if (equal? tuplaX tuplaY)
       MAX
       (sqrt (+ (* (- (car tuplaX) (car tuplaY)) (- (car tuplaX) (car tuplaY))) (* (- (cdr tuplaX) (cdr tuplaY)) (- (cdr tuplaX) (cdr tuplaY)))))
                                          ))

; Función que calcula la longitud de una lista
(define (length lista)
  (length-rec lista 0)
)

(define (length-rec lista i)
  (if (or (null? lista) (not (pair? lista)))
    i
    (length-rec (cdr lista) (+ i 1)))
)

; Función que o hace lo mismo que append o crea la lista
(define (junta cosa1 cosa2)
  (
    if (and (list? cosa1) (list? cosa2))
      (append cosa1 cosa2)
      (
        if (list? cosa1)
           (append cosa1 (list cosa2))
           (junta cosa2 cosa1)
      )
  )
)

; Funcion que devuelve la primera mitad de una lista
; Nota, quotient es la función que devuelve la división entera entre dos enteros
(define (1ªmitad lista)
  (let ((n (length lista)))
  (reduce (lambda(x y) (if (< (length x) (quotient n 2)) (junta y x) x)) lista null))
)

; Funcion que devuelve la segunda mitad de una lista
(define (2ªmitad lista)
  (
    2ªmitad-rec lista (length lista) 0
  )
)

(define (2ªmitad-rec lista n i)
  (
    if (< i (quotient n 2))
       (2ªmitad-rec (cdr lista) n (+ i 1))
       (
         if (null? lista)
            null
           (cons (car lista) (2ªmitad-rec (cdr lista) n (+ i 1)))
       )
  )
)

; Funcion que combina dos listas tal y como lo requiere el algoritmo
(define (combinar delta x0 lista)
  (let ((banda_p1 (funcion1 delta x0 lista))
        (banda_p2 (funcion2 delta x0 lista)))
    (todos_con_pares banda_p1 banda_p2 delta)))

(define (funcion1 delta x0 lista)
  (if (null? lista)
      null
      (if (and  (> (car (car lista) ) (- x0 delta)) (< (car (car lista)) x0))
          (cons (car lista) (funcion1 delta x0 (cdr lista)))
          (funcion1 delta x0 (cdr lista))
          )
      )
  )

(define (funcion2 delta x0 lista)
  (if (null? lista)
      null
      (if (and  (> (car (car lista) ) x0) (< (car (car lista)) (+ x0 delta)))
          (cons (car lista) (funcion2 delta x0 (cdr lista)))
          (funcion2 delta x0 (cdr lista))
          )
      )
  )

(define (minimo_distancias punto lista_puntos delta)
  (reduce (lambda (x y) (if (and (< (calculaDistancia y punto) x) (> (calculaDistancia y punto) 0)) (calculaDistancia y punto) x)) lista_puntos delta))

(define (todos_con_pares lista_puntos1 lista_puntos2 min-distancia-hasta-ahora)
  (reduce (lambda (x y) (if (< (minimo_distancias y lista_puntos1 x) x) (minimo_distancias y lista_puntos1 x) x)) lista_puntos2 min-distancia-hasta-ahora))

;Función principal
(define (busca-distancia-minima lista)
  (
     cond ((null? lista) MAX)
          ((null? (cdr lista)) MAX)
          ; Caso base: len(lista) = 2
          ((null? (cdr (cdr lista))) (calculaDistancia (car lista) (car (cdr lista))))
          ; Caso base: len(lista) = 3
          ((null? (cdr (cdr (cdr lista)))) (min (min (calculaDistancia (car lista) (car (cdr lista))) (calculaDistancia (car (cdr lista)) (car (cdr (cdr lista))))) (calculaDistancia (car lista) (car (cdr (cdr lista))))))
          ; Caso general:
          (else (let (
                        (x (1ªmitad lista))
                        (y (2ªmitad lista))
                      )
                 (combinar (min (busca-distancia-minima x) (busca-distancia-minima y))
                           (car (car y))
                           lista)
                )
          )
   )
)

; Leer fichero
(define (next-line-it file)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
      (cons line (next-line-it file))
      )))

(define (devuelveLista lista) (
    if (void? lista)
       null
       (if (null? lista)
           lista
           (cons (cons (string->number (car (string-split (car lista) " "))) (string->number (car (cdr (string-split (car lista) " "))))) (devuelveLista (cdr lista)))
                                        )))

(define listaPtos (devuelveLista (call-with-input-file "ej_pts_europa.txt" next-line-it)))

(define puntos-ordenados (sort listaPtos < #:key car))

; Lamentablemente, no puedo ejecutar este algoritmo con los puntos de ej_pts_01.txt porque es una lista de números, no una lista de puntos, por lo que no funciona.
; Pero si puedo hacerlo con ej_pts_europa, y se que el algoritmo funciona porque obtengo el mismo resultado que en el ejercicio 1 por fuerza bruta.
; Ejecución principal
(displayln puntos-ordenados)
(displayln 'Solucion)
(busca-distancia-minima puntos-ordenados)