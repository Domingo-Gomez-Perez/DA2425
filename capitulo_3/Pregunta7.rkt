#lang racket
(require math/statistics)

; Función para leer puntos desde un archivo
(define (next-line-it file)
  (let ((line (read-line file 'any)))  ; Lee una línea del archivo
    (if (eof-object? line)  ; Si el final del archivo se ha alcanzado
        '()  ; Retorna una lista vacía
        (let ((coords (map string->number (string-split line " "))))  ; Convierte la línea en números
          (cons (cons (car coords) (cadr coords))  ; Crea un par (x, y)
                (next-line-it file))))))  ; Llama recursivamente para la siguiente línea

; Función para dividir los puntos en dos listas manteniendo el orden
(define (dividir-puntos puntos)
  (let ((n (length puntos))) ; Calcula la longitud de puntos-ordenados
      (let ((punto-medio (list-ref puntos (quotient n 2)))) ; Toma el punto en la posición media
        (let ((x0 (car punto-medio)))  ; Coordenada x de la frontera

    ; Divide la lista en dos manteniendo el orden
    (let ((resultado (foldl (lambda (punto acc)
                              (let ((P1 (car acc))
                                    (P2 (cdr acc)))
                                (if (< (car punto) x0)
                                    (cons (cons punto P1) P2) ; Agrega a P1 manteniendo orden
                                    (cons P1 (cons punto P2))))) ; Agrega a P2 manteniendo orden
                            (cons '() '()) ; Inicializa las listas P1 y P2
                            puntos))) ; Recorre los puntos

      ; Extraemos las listas resultantes
      (let ((P1 (reverse (car resultado))) ; Invierte P1 para mantener el orden original
            (P2 (reverse (cdr resultado)))) ; Invierte P2 para mantener el orden original
        ; Mostrar resultados
        (displayln "Lista1") (displayln P1)
        (displayln "Lista2") (displayln P2)))))))

; Función principal para leer y dividir puntos
(define (procesar-archivo archivo)
  (let ((puntos (call-with-input-file archivo next-line-it)))
    (dividir-puntos puntos)))

(procesar-archivo "ej_pts_prueba.txt")
