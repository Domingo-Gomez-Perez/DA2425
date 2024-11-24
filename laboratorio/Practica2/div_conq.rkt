#lang racket

; PREGUNTA 1
(define (busca x lista)
    (busca-aux x lista 0 (get-length lista)))
            
(define (busca-aux x lista i j)
    (define m (quotient (- (+ i j) 1) 2))
    (define value (get-value lista m))
    (if (>= i j)    
        null                     
        (cond ((= value x) m)
              ((< value x) (busca-aux x lista (+ m 1) j))
              (else (busca-aux x lista i m)))))

(define (get-length lista)
    (if (vector? lista)    
        (vector-length lista)   
        (length lista))) 

(define (get-value lista index)
    (define (get-value-list lista index)
        (if (= index 0)
            (car lista)
            (get-value (cdr lista) (- index 1))))   
    (if (vector? lista)    
        (vector-ref lista index)   
        (get-value-list lista index))) 


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ejemplos de uso: list
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Entrada: (busca 8 '(1 2 3 4 5 6 7 8)) - Salida esperada: 7 - Resultado: ")
(display (busca 8 '(1 2 3 4 5 6 7 8))) ; Devuelve 7 (el índice del valor 8)
(newline)

(display "Entrada: (busca 6 '(1 2 3 4 5 6 7 8)) - Salida esperada: 5 - Resultado: ")
(display (busca 6 '(1 2 3 4 5 6 7 8))) ; Devuelve 5 (el índice del valor 6)
(newline)

(display "Entrada: (busca 2 '(1 2 3 4 5 6 7 8)) - Salida esperada: 1 - Resultado: ")
(display (busca 2 '(1 2 3 4 5 6 7 8))) ; Devuelve 1 (el índice del valor 2)
(newline)

(display "Entrada: (busca 4 '(1 2 3 4 5 6 7 8)) - Salida esperada: 3 - Resultado: ")
(display (busca 4 '(1 2 3 4 5 6 7 8))) ; Devuelve 3 (el índice del valor 4)
(newline)

(display "Entrada: (busca 1 '(1 2 3 4 5 6 7 8)) - Salida esperada: 0 - Resultado: ")
(display (busca 1 '(1 2 3 4 5 6 7 8))) ; Devuelve 0 (el índice del valor 1)
(newline)

(display "Entrada: (busca 7 '(1 2 3 4 5 6 7 8)) - Salida esperada: 6 - Resultado: ")
(display (busca 7 '(1 2 3 4 5 6 7 8))) ; Devuelve 6 (el índice del valor 7)
(newline)

(display "Entrada: (busca 5 '(1 2 3 4 5 6 7 8)) - Salida esperada: 4 - Resultado: ")
(display (busca 5 '(1 2 3 4 5 6 7 8))) ; Devuelve 4 (el índice del valor 5)
(newline)

(display "Entrada: (busca 9 '(1 2 3 4 5 6 7 8)) - Salida esperada: null - Resultado: ")
(display (busca 9 '(1 2 3 4 5 6 7 8))) ; Devuelve null (el valor 9 no está en la lista)
(newline)

(display "Entrada: (busca 0 '(1 2 3 4 5 6 7 8)) - Salida esperada: null - Resultado: ")
(display (busca 0 '(1 2 3 4 5 6 7 8))) ; Devuelve null (el valor 0 no está en la lista)
(newline)

(display "Entrada: (busca 3 '(3 3 3 3 3 3 3 3)) - Salida esperada: 3 - Resultado: ");

(display (busca 3 '(3 3 3 3 3 3 3 3))) ; Devuelve 3 (el índice es indistinto, ya que todos los elementos son iguales)
(newline)


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ejemplos de uso: vector
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Entrada: (busca 8 (vector 1 2 3 4 5 6 7 8)) - Salida esperada: 7 - Resultado: ")
(display (busca 8 (vector 1 2 3 4 5 6 7 8))) ; Devuelve 7 (el índice del valor 8)
(newline)

(display "Entrada: (busca 6 (vector 1 2 3 4 5 6 7 8)) - Salida esperada: 5 - Resultado: ")
(display (busca 6 (vector 1 2 3 4 5 6 7 8))) ; Devuelve 5 (el índice del valor 6)
(newline)

(display "Entrada: (busca 2 (vector 1 2 3 4 5 6 7 8)) - Salida esperada: 1 - Resultado: ")
(display (busca 2 (vector 1 2 3 4 5 6 7 8))) ; Devuelve 1 (el índice del valor 2)
(newline)

(display "Entrada: (busca 4 (vector 1 2 3 4 5 6 7 8)) - Salida esperada: 3 - Resultado: ")
(display (busca 4 (vector 1 2 3 4 5 6 7 8))) ; Devuelve 3 (el índice del valor 4)
(newline)

(display "Entrada: (busca 1 (vector 1 2 3 4 5 6 7 8)) - Salida esperada: 0 - Resultado: ")
(display (busca 1 (vector 1 2 3 4 5 6 7 8))) ; Devuelve 0 (el índice del valor 1)
(newline)

(display "Entrada: (busca 7 (vector 1 2 3 4 5 6 7 8)) - Salida esperada: 6 - Resultado: ")
(display (busca 7 (vector 1 2 3 4 5 6 7 8))) ; Devuelve 6 (el índice del valor 7)
(newline)

(display "Entrada: (busca 5 (vector 1 2 3 4 5 6 7 8)) - Salida esperada: 4 - Resultado: ")
(display (busca 5 (vector 1 2 3 4 5 6 7 8))) ; Devuelve 4 (el índice del valor 5)
(newline)

(display "Entrada: (busca 9 (vector 1 2 3 4 5 6 7 8)) - Salida esperada: null - Resultado: ")
(display (busca 9 (vector 1 2 3 4 5 6 7 8))) ; Devuelve null (el valor 9 no está en la lista)
(newline)

(display "Entrada: (busca 0 (vector 1 2 3 4 5 6 7 8)) - Salida esperada: null - Resultado: ")
(display (busca 0 (vector 1 2 3 4 5 6 7 8))) ; Devuelve null (el valor 0 no está en la lista)
(newline)

(display "Entrada: (busca 3 (vector 3 3 3 3 3 3 3 3)) - Salida esperada: 3 - Resultado: ")
(display (busca 3 (vector 3 3 3 3 3 3 3 3))) ; Devuelve 3 (el índice es indistinto, ya que todos los elementos son iguales)
(newline)


; PREGUNTA 2)
;
; Para una lista con longitud n la cota superior para la cantidad de llamadas 
; será de log2 n, ya que para cada llamada recursiva se divide la lista en dos.
;
; La búsqueda binaria tiene una complejidad temporal de 
; O(log2 n) y espacial también de O(log2 n).

; PREGUNTA 3)
;
; El coste se puede considerar como O(log2 n) en términos de operaciones bit, ya que el número de 
; bits necesarios para representar un número hasta n es O(log2 ⁡n).
;
; La complejidad total será el producto del número de comparaciones y el coste de cada operación
; O(log2 n) * O(log2 n) = O((log2 n)^2).

; PREGUNTA 4)
;
; El teorema maestro puede aplicarse, puesto que se trata de un algoritmo del tipo divide y vencerás.
; En este caso, a = el número de llamadas recursivas = 1
;               b = en cuánto se divide el tamaño del problema = 2
;               c = el coste de descomponer y combinar = 0
;
; Por lo tanto, como b^c = 2^0 = 1 = a, la complejidad asíntotica es O(n^c log2 n) = O(n^0 log2 n) = O(log2 n)

; PREGUNTA 5)
(define (busca-iter x lista)
    (define (busca-aux-iter lista i j x)
        (let loop ((i i) (j j))
                  (if (> i j)
                      -1
                      (let* ((m (+ i (quotient (- j i) 2)))
                             (value (get-value lista m)))
                            (cond ((= value x) m)
                                  ((< value x) (loop (+ m 1) j))
                                  (else (loop i (- m 1))))))))
    (busca-aux-iter lista 0 (get-length lista) x))

(busca-iter 6 (vector 1 2 3 4 5 6 7 8))
