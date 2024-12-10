#lang racket

#| vamos a crear el algoritmo en Racket. Como son muchas cosas por separado, vamos a crear cada
procedimiento por separado para poder ir probandolo por partes.

Se podria poner todo dentro del mismo define para que solo dando la lista se pueda ejecutar el algoritmo.
Pero es mejor tenerlo asi para poder ver cada paso por separado en este caso. |#

; Función que convierte las líneas de un archivo en una lista de puntos
(define (lines-to-list file)
  (define (lines-to-list-iter file lista)
    (let ([linea (read-line file 'any)]) ; leer la línea actual
      (if (eof-object? linea)
          lista ; si es el final del archivo, devolver la lista
          (lines-to-list-iter file
                              (cons (formatear-linea linea)
                                    lista))))) ; agregar la línea y llamar recursivamente

  (cdr (reverse (lines-to-list-iter file '())))) ; empezamos con una lista vacía y luego la invertimos

; Función para formatear cada línea y convertirla en un punto (par de coordenadas)
(define (formatear-linea linea)
  (let* ([values (string-split linea " ")] ; Divide la línea en dos valores
         [x (string->number (first values))] ; Convierte el primer valor a número
         [y (string->number (second values))] ; Convierte el segundo valor a número
         [point (list x y)]) ; Crea una lista con x e y
    point))

; Llamada para leer el archivo y almacenar los puntos
(define puntos (call-with-input-file "ej_pts_europa.txt" lines-to-list))

; Mostrar los puntos leídos (para probar solo)
; (display puntos)

; ahora el algoritmo en si. Aqui si que usamos Black Box para juntar todo
(define (puntos-mas-cercanos lista)
  ; procedimientos adicionales al algoritmo
  (define (square x)
    (* x x))

  ; son tuplas de 2 elementos (x,y)
  (define (distancia-euc list1 list2)
    (+ (square (- (car list1) (car list2))) (square (- (cadr list1) (cadr list2)))))

  (define (puntos-mas-cercanos-rec lista puntos-minimos dist-min)
    (cond
      [(null? lista)
       puntos-minimos] ; Cuando la lista se ha recorrido por completo, devuelve los puntos más cercanos encontrados.
      [else
       (let ([resultado
              (puntos-mas-cercanos-helper
               (car lista)
               (cdr lista)
               (first puntos-minimos)
               (second puntos-minimos)
               dist-min)]) ; Llama al helper para calcular los puntos más cercanos en el subgrupo.
         (puntos-mas-cercanos-rec
          (cdr lista)
          resultado
          (distancia-euc (first resultado)
                         (second resultado))))])) ; Continúa recursivamente con el resto de la lista.

  (define (puntos-mas-cercanos-helper lista puntos-restantes punto1-min punto2-min dist-min)
    (cond
      [(null? puntos-restantes)
       (list
        punto1-min
        punto2-min)] ; Si ya no quedan puntos por comparar, devuelve los dos puntos más cercanos encontrados.
      [else
       (let* ([punto (car puntos-restantes)] ; Toma el primer punto de la lista.
              [distancia
               (distancia-euc
                lista
                punto)]) ; Calcula la distancia entre el primer punto de la lista y el punto actual.
         (if (< distancia dist-min) ; Si la distancia calculada es menor que la mínima registrada.
             (puntos-mas-cercanos-helper lista
                                         (cdr puntos-restantes)
                                         lista
                                         punto
                                         distancia) ; Si es así, actualiza los puntos más cercanos.
             (puntos-mas-cercanos-helper lista
                                         (cdr puntos-restantes)
                                         punto1-min
                                         punto2-min
                                         dist-min)))])) ; Si no, mantiene los puntos anteriores.

  ; inicio de la recursion
  (if (or (null? lista) (null? (cdr lista)))
      '() ; Si la lista tiene menos de dos puntos, retorna una lista vacía
      (puntos-mas-cercanos-rec
       lista
       (list (car lista) (cadr lista)) ; Inicializa los dos primeros puntos
       (distancia-euc (car lista)
                      (cadr lista))))) ; Calcula la distancia entre los dos primeros puntos

; Prueba del procedimiento
(define resultado (puntos-mas-cercanos puntos))

; Mostrar el resultado
(display "Los puntos más cercanos son:\n")
(display (car resultado))
(display " y ")
(display (cadr resultado))
