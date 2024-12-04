#lang racket

; Función para dividir una lista de puntos en dos subconjuntos P1 y P2
(define (dividir-puntos puntos)
  ; procedimientos adicionales para coger cada mitad de la lista
  (define (primeros-n lista n)
    (if (= n 0)
        '()
        (cons (car lista) (primeros-n (cdr lista) (- n 1)))))

  (define (ultimos-n lista n)
    (if (= n 0)
        lista
        (drop (cdr lista) (- n 1))))

        
  (let* ([puntos-ordenados puntos] ; ordenar los puntos por su coordenada x
         [n (length puntos-ordenados)] ; largo de la lista de puntos
         [mitad (quotient n 2)] ; calcular la mitad de la lista
         [P1 (primeros-n puntos-ordenados mitad)] ; puntos a la izquierda de la línea vertical
         [P2 (ultimos-n puntos-ordenados mitad)] ; puntos a la derecha de la línea vertical
         [x0 (car (last P1))]) ; el valor de x del último punto de P1
    (list P1 P2 x0))) ; devolver P1, P2 y el valor de corte x0

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
(define puntos (call-with-input-file "europa_x_creciente.txt" lines-to-list))


; Dividir los puntos
(define resultado (dividir-puntos puntos))

; Mostrar los resultados de manera ordenada
(define P1 (car resultado)) ; Subconjunto P1
(define P2 (cadr resultado)) ; Subconjunto P2
(define x0 (caddr resultado)) ; El valor de corte x0

(display "Puntos en P1:\n")
(for-each (lambda (p)
            (display p)
            (newline))
          P1) ; Mostrar los puntos en P1
(newline)

(display "Puntos en P2:\n")
(for-each (lambda (p)
            (display p)
            (newline))
          P2) ; Mostrar los puntos en P2
(newline)

(display "Punto de corte (x0):\n")
(display x0) ; Mostrar el valor de corte x0
(newline)



