#lang racket
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


(define MAX 10000)
(define (reduce proc lista valor)
  (if (null? lista)
      valor
      (reduce proc (cdr lista) (proc valor (car lista)))))

(define (minimo lista)
  (reduce (lambda (x y) (if (< x y) x y)) lista MAX))

(define (distancia p1 p2)
  (+ (* (- (car p1) (car p2))  (- (car p1) (car p2)))
     (* (- (cadr p1) (cadr p2))  (- (cadr p1) (cadr p2)))
     ))

(define (minimo_distancias punto lista_puntos)
  (reduce (lambda (x y) (if (and (< (distancia y punto) x) (> (distancia y punto) 0)) (distancia y punto) x))    lista_puntos MAX))

(define (todos_con_todos lista_puntos)
  (reduce (lambda (x y) (if (< (minimo_distancias y lista_puntos) x)  (minimo_distancias y lista_puntos) x))    lista_puntos MAX))


(define (todos_con_pares lista_puntos1 lista_puntos2)
  (reduce (lambda (x y) (if (< (minimo_distancias y lista_puntos1) x)  (minimo_distancias y lista_puntos1) x))    lista_puntos2 MAX))


 
(define lista_puntos '((1 3) (4 5) (6 7) (6.3 7.2)))
(minimo_distancias '(10 10) lista_puntos)
(todos_con_pares lista_puntos '((1 4) (5 10)))

(define (combinar delta x0 lista)
  (let ((banda_p1 (funcion1 delta x0 lista))
        (banda_p2 (funcion2 delta x0 lista)))
    (todos_con_pares banda_p1 banda_p2)))


;Función para dividir puntos y calcular distancia mínima
(define (distancia-minima puntos)
  
  ;Función auxiliar recursiva
  (define (distancia-minima-rec puntos)
    (define n (length puntos))
    
    ;Caso base: si hay pocos puntos, calcula distancia mínima directamente
    (if (<= n 3)
        (let loop ((i 0) (min-dist +inf.0))
          (if (>= i (- n 1))
              min-dist
              (let loop-inner ((j (+ i 1)) (current-min min-dist))
                (if (>= j n)
                    (loop (+ i 1) current-min)
                    (loop-inner (+ j 1) (min current-min (distancia (list-ref puntos i) (list-ref puntos j))))))))
        
        ; Caso recursivo: dividir puntos y comparar distancias
        (let* ((mitad (quotient n 2))
               (P1 (take puntos mitad))
               (P2 (drop puntos mitad))
               (distancia-P1 (distancia-minima-rec P1))
               (distancia-P2 (distancia-minima-rec P2))
               (delta (min distancia-P1 distancia-P2))
               (x0 (car (list-ref puntos mitad))))
          
          (combinar delta x0 puntos))))
  
  ; Iniciar el cálculo de distancia mínima recursivamente
  (distancia-minima-rec puntos))

;Función para leer puntos desde un archivo
(define (leer-puntos-desde-archivo filename)
  (define puntos '())
  (define (procesar-linea file)
    (let ((line (read-line file 'any)))
      (unless (eof-object? line)
        (let ((coords (map string->number (string-split line " "))))
          (set! puntos (cons coords puntos)))
        (procesar-linea file))))
  (call-with-input-file filename procesar-linea)
  puntos)

;Uso con archivo de puntos
(define puntos (leer-puntos-desde-archivo "ej_pts_01.txt"))

(distancia-minima puntos)




