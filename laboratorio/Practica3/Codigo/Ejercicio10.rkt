#lang racket
; Ejercicio 10 de la práctica 3

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
  (reduce (lambda(x y) (+ x 1)) lista 0)
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
(define (1amitad lista)
  (let ((n (length lista)))
  (reduce (lambda(x y) (if (< (length x) (quotient n 2)) (junta y x) x)) lista null))
)

; Funcion que devuelve la segunda mitad de una lista
(define (2amitad lista)
  (
    2amitad-rec lista (length lista) 0
  )
)

(define (2amitad-rec lista n i)
  (
    if (< i (quotient n 2))
       (2amitad-rec (cdr lista) n (+ i 1))
       (
         if (null? lista)
            null
           (cons (car lista) (2amitad-rec (cdr lista) n (+ i 1)))
       )
  )
)

; Funcion que combina dos listas tal y como lo requiere el algoritmo
; 
(define (combinar delta x0 lista)
  (let ((banda_x1 (funcion1 delta x0 lista null))
        (banda_x2 (funcion2 delta x0 lista null)))
    (comparacion-constante (append banda_x1 banda_x2) delta 0)))

(define (funcion1 delta x0 lista sol)
  (if (null? lista)
      sol
      (if (and  (> (car (car lista) ) (- x0 delta)) (< (car (car lista)) x0))
          (
            if (null? sol)
               (funcion1 delta x0 (cdr lista) (list (car lista)))
               (funcion1 delta x0 (cdr lista) (coloca (car lista) sol))
          )
          (funcion1 delta x0 (cdr lista) sol)
          )
      )
  )

(define (coloca elem lista)
  (if (null? lista)
      (list elem)
  (if (null? (cdr lista))
    (
      if (< (cdr (car lista)) (cdr elem))
         (append (list (car lista)) (list elem))
         (cons elem (list (car lista)))
    )
    (
      if (< (cdr (car lista)) (cdr elem))
         (append (list (car lista)) (coloca elem (cdr lista)))
         (append (list elem) lista)
    )
  )
  )  
)

(define (funcion2 delta x0 lista sol)
  (if (null? lista)
      sol
      (if (and  (> (car (car lista) ) x0) (< (car (car lista)) (+ x0 delta)))
          (
            if (null? sol)
               (funcion1 delta x0 (cdr lista) (list (car lista)))
               (funcion1 delta x0 (cdr lista) (coloca (car lista) sol))
          )
          (funcion2 delta x0 (cdr lista) sol)
          )
      )
  )

(define (for-5 elem listaY delta i)
  (
    if (or (>= i 5) (null? listaY))
       delta
       (for-5 elem (cdr listaY) (min (calculaDistancia elem (car listaY)) delta) (+ i 1))
  )
)

(define (comparacion-constante lista delta i)
  (let (
         (len (length lista))
       )
        (if (< i len)
          (comparacion-constante (cdr lista) (for-5 (car lista) (cdr lista) delta 0) (+ i 1))
          delta
        )
  )
)

;Función principal
(define (busca-distancia-minima listaX)
  (
     cond ((null? listaX) MAX)
          ((null? (cdr listaX)) MAX)
          ; Caso base: len(lista) = 2
          ((null? (cdr (cdr listaX))) (calculaDistancia (car listaX) (car (cdr listaX))))
          ; Caso base: len(lista) = 3
          ((null? (cdr (cdr (cdr listaX)))) (min (min (calculaDistancia (car listaX) (car (cdr listaX))) (calculaDistancia (car (cdr listaX)) (car (cdr (cdr listaX))))) (calculaDistancia (car listaX) (car (cdr (cdr listaX))))))
          ; Caso general:
          (else (let (
                        (x1 (1amitad listaX))
                        (x2 (2amitad listaX))
                      )
                 (combinar (min (busca-distancia-minima x1) (busca-distancia-minima x2))
                           (car (car x2))
                           listaX)
                 )
          )
   )
)

; Llamada a la función principal
; Esto cuenta como preprocesado, por lo que no necesito calcular su complegidad
(define (minimo lista)
  (busca-distancia-minima (sort lista < #:key car))
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
(define listaEjemplo (list (cons 1 2) (cons 3 4) (cons 5 6) (cons 7 8) (cons 9 10)))

;Ejecución
(displayln 'Ejemplo)
(minimo listaEjemplo)
(displayln 'Solución)
(minimo listaPtos)
; Solución teorica:
; Es cierto que es más corto, porque he posido quitar una función. Pero es más, podría fusionar funcion1 y funcion2 en una sola si quisiera