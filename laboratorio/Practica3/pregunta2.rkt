#lang racket

(require math/statistics) ; Librería opcional para operaciones avanzadas

; Función para verificar elementos en listas
(define (every pred lista)
  (cond
    ((null? lista) #t) ; Lista vacía siempre cumple
    ((not (pred (car lista))) #f) ; Si un elemento no cumple, retorna #f
    (else (every pred (cdr lista))))) ; Recurre al resto de la lista

; Lee puntos desde un archivo, procesando cada línea
(define (cargar-puntos archivo)
  (call-with-input-file archivo
    (lambda (file)
      (let iterar ((linea (read-line file 'any)) (puntos '()))
        (if (eof-object? linea)
            puntos ; Devuelve la lista acumulada cuando llega al final
            (let ((elementos (string-split linea " ")))
              (if (and (= (length elementos) 2) ; Solo admite líneas con 2 elementos
                       (every cadena-es-numero? elementos)) ; Verifica si son números
                  (iterar (read-line file 'any)
                          (cons (map string->number elementos) puntos)) ; Agrega puntos convertidos
                  (error "Formato inválido: " linea))))))))

; Comprueba si una cadena representa un número válido
(define (cadena-es-numero? texto)
  (not (false? (string->number texto))))

; Calcula la distancia entre dos puntos dados
(define (calcular-distancia punto1 punto2)
  (sqrt (+ (sqr (- (car punto1) (car punto2))) ; Diferencia en x
           (sqr (- (cadr punto1) (cadr punto2)))))) ; Diferencia en y

; Invierte una lista usando un método auxiliar
(define (invertir-lista lista)
  (let loop ((resto lista) (acumulado '()))
    (if (null? resto)
        acumulado
        (loop (cdr resto) (cons (car resto) acumulado)))))

; Encuentra la menor distancia entre los puntos
(define (distancia-mas-corta puntos)
  (define (evaluar-distancia i j distancia-minima punto1 punto2 restantes1 restantes2)
    (if (< j (length puntos))
        (let ((distancia (calcular-distancia (car restantes1) (car restantes2))))
          (if (< distancia distancia-minima)
              (evaluar-distancia i (+ j 1) distancia (car restantes1) (car restantes2) restantes1 (cdr restantes2))
              (evaluar-distancia i (+ j 1) distancia-minima punto1 punto2 restantes1 (cdr restantes2))))
        (if (< i (- (length puntos) 1))
            (evaluar-distancia (+ i 1) (+ i 2) distancia-minima punto1 punto2 (cdr restantes1) (cddr restantes1))
            (list distancia-minima punto1 punto2))))

  (evaluar-distancia 0 1 +inf.0 '() '() puntos (cdr puntos)))

(display "Introduce el nombre del archivo con puntos (ejemplo: archivo_puntos.txt): ")
(define archivo (read-line))

; Programa principal que carga y procesa los puntos
(define (programa-principal archivo)
  (define puntos (cargar-puntos archivo))
  (define resultado (distancia-mas-corta (invertir-lista puntos))) ; Usa la lista invertida
  (define distancia (car resultado))
  (define punto1 (cadr resultado))
  (define punto2 (caddr resultado))
  (printf "La distancia más corta es ~a entre los puntos ~a y ~a\n" distancia punto1 punto2))

(programa-principal archivo)
