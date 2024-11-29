#lang racket
(require math/statistics)

; Complejidad temporal = 0(N log N) Complejidad espacial = 0(N)

(define (next-line-it file)
  (let ((line (read-line file 'any)))  ; Lee una línea del archivo
    (if (eof-object? line)  ; Si el final del archivo se ha alcanzado
        '()  ; Retorna una lista vacía
        (let ((coords (map string->number (string-split line " "))))  ; Convierte la línea en números
          (cons (cons (car coords) (cadr coords))  ; Crea un par (x, y)
                (next-line-it file))))))  ; Llama recursivamente para la siguiente línea

; Función para dividir los puntos en dos listas balanceadas con respecto a x = x0
(define (dividir-puntos puntos)
  (let ((puntos-ordenados (sort puntos (lambda (a b) (< (car a) (car b)))))) ; Ordena por coordenada x
    (let ((n (length puntos-ordenados))) ; Calcula la longitud de puntos-ordenados
      (let ((punto-medio (list-ref puntos-ordenados (quotient n 2)))) ; Toma el punto en la posición media
        (let ((x0 (car punto-medio)))  ; Coordenada x de la frontera

    ; Inicializamos P1 y P2 como listas vacías
    (let ((P1 '()) (P2 '()))
      ; Usamos map para recorrer los puntos y agregar a P1 o P2 usando if
      (map (lambda (punto)
             (if (< (car punto) x0)
                 (set! P1 (cons punto P1)) ; Agrega a P1 si x < x0
                 (set! P2 (cons punto P2)))) ; Agrega a P2 si x > x0
           puntos-ordenados)
      
      ; Mostramos los resultados
      (displayln "Lista1") (displayln P1)
      (displayln "Lista2") (displayln P2)
      
      ; Devolvemos las listas P1 y P2 como resultado
      ))))))

; Función principal para leer y dividir puntos
(define (procesar-archivo archivo)
  (let ((puntos (call-with-input-file archivo next-line-it)))
    (dividir-puntos puntos)))

(procesar-archivo "ej_pts_02.txt")
