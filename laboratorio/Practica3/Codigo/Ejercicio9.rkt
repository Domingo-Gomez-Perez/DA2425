#lang racket
; Ejercicio 9 de la práctica

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
    (comparacion-constante banda_x1 banda_x2 delta 0)))

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

(define (comparacion-cinco elem listaY delta )
  (
    if (null? listaY)
       null
       (if (<= (cdr (car listaY)) (- (cdr elem) delta))
          (comparacion-cinco elem (cdr listaY) delta)
          listaY
       )
  ) 
)

(define (comparacion-constante y1 y2 delta i)
  (let (
         (leny1 (length y1))
         (leny2 (length y2))
       )
  (if (< i leny1)
    (comparacion-constante (cdr y1) y2
                           (if (>= (- leny2 (length (comparacion-cinco (car y1) y2 delta))) leny2)
                                      delta
                                      (for-5 (car y1) y2 delta 0)
                           )
      (+ i 1)                         
    )
    delta
  ))
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

; Lamentablemente, no puedo ejecutar este algoritmo con los puntos de ej_pts_01.txt porque es una lista de números, no una lista de puntos, por lo que no funciona.
; Pero si puedo hacerlo con ej_pts_europa, y se que el algoritmo funciona porque obtengo el mismo resultado que en el ejercicio 1 por fuerza bruta.
; Ejecución principal
(displayln listaPtos)
(displayln 'Solucion)
(minimo listaPtos)
; Solución teorica:
;  - Separar X en dos arrays se puede hacer en tiempo polinómico, porque aprovechamos el preprocesado de la lista de puntos y solo tenemos que partir ese array a la mitad.
;  - Crear Y1 e Y2 en base a X1 y X2. Esto es más complicado, porque aprovecho y creo directamente B1 y B2. Para crear B1 y B2 tengo que quedarme con los puntos de X1 y X2
; que tengan su coordenada 'x' mayor o menor que x0 +- delta. Para evitar algoritmos de ordenación que empeoren la complegidad, una vez que selecciono el punto que merece estar
; en B1 y B2, le añado a un array (o más bien, lista enlazada) en función de su coordenada 'y', así logro evitar recorrer X1 y X2 de nuevo para ordenarlos en función de 'y'.
;  - Comprobar si alguna pareja 'mixta' mejora delta: Esto es lineal, gracias a que limitamos el número de parejas que hay que comprobar a 5, por cada punto de B1 (o de B2).