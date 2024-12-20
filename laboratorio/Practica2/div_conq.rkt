#lang racket

; 1) Traduzca el código dado de Python a Scheme, utilizando list, car y cdr y que el código sea también
; válido si se utiliza el tipo vector.

(define (busca x estructura)
  (busca-aux x estructura 0 (if (list? estructura)
                                 (length estructura)  ; Longitud de una lista
                                 (vector-length estructura))))  ; Longitud de un vector

(define (busca-aux x estructura i j)
  (if (>= i j)
      #f  ; Devuelve #f si no se encuentra el elemento
      (let* ((m (quotient (+ i (- j 1)) 2))
             (m-val (elemento-n m estructura)))  ; Compatibilidad con listas y vectores
        (cond
          ((= m-val x) m)  ; Se encuentra el elemento
          ((< m-val x) (busca-aux x estructura (+ m 1) j))  ; Busca en la mitad derecha
          (else (busca-aux x estructura i m))))))  ; Busca en la mitad izquierda

; Función auxiliar para acceder al enésimo elemento de una lista o vector.
(define (elemento-n n estructura)
  (cond
    ((list? estructura)  ; Caso: estructura es una lista
     (if (= n 0)
         (car estructura)  ; Acceso al primer elemento
         (elemento-n (- n 1) (cdr estructura))))  ; Recursión con cdr
    ((vector? estructura)  ; Caso: estructura es un vector
     (vector-ref estructura n))  ; Acceso al elemento del vector
    (else
     (error "estructura debe ser una lista o un vector"))))  ; Error si no es lista ni vector

; PRUEBAS lista y vector
(busca 5 '(1 3 5 7 9)) ; Devuelve 2
(busca 7 #(1 3 5 7 9)) ; Devuelve 3

; 2) Calcula una cota superior para la cantidad de llamadas a busca_aux que realiza el algoritmo
; en función de la longitud de la lista de entrada. Acota la complejidad espacial y temporal de la
; búsqueda por bipartición.

; El algoritmo de búsqueda binaria divide la lista o vector en mitades en cada llamada recursiva. 
; Esto significa que el número máximo de llamadas a la función "busca-aux" está dado por la cantidad de veces que podemos dividir la longitud inicial "n" entre 2 hasta llegar a 1.
; Esto equivale aproximadamente a ⌊log2(n)⌋ + 1.

; Complejidad temporal: Es O(log n) porque en cada paso se realiza una comparación constante, y el número de pasos es proporcional a log2(n).

; Complejidad espacial: También es O(log n), ya que cada llamada recursiva ocupa espacio en la pila de ejecución, y el número de llamadas es proporcional a log2(n).

; En resumen, la eficiencia del algoritmo es alta tanto en tiempo como en espacio, especialmente para entradas grandes.

; 3) Suponiendo que la extensión de la representación binaria de cada uno de los números de la lista
; está acotada por log2 n, deduce una cota superior asintótica para la complejidad computacional
; del algoritmo en términos de operaciones bit.

; El algoritmo de búsqueda binaria realiza un máximo de "log n" pasos, ya que divide la lista o vector en mitades en cada iteración.
; En cada paso, compara números cuya representación binaria está acotada por "log2 n" bits. El costo de cada comparación es proporcional a "log n" operaciones bit.

; El número total de pasos es "O(log n)", y cada paso cuesta "O(log n)" operaciones bit. Por lo tanto, la complejidad total del algoritmo en términos de operaciones bit es:

; O(log n) * O(log n) = O((log n)^2)
; La cota superior asintótica para la complejidad computacional del algoritmo es "O((log n)^2)".

; 4) ¿Se puede aprovechar el teorema maestro para las dos preguntas anteriores?

; El algoritmo cumple la relación de recurrencia:

; T(n) = T(n/2) + O(1)

; Esto significa que, en cada paso, el problema se reduce a la mitad y se realiza un trabajo constante. Para analizar esta recurrencia, aplicamos el Teorema Maestro.

; 1. Determinamos log_b(a):
;    - En este caso, a = 1, b = 2, por lo que log_b(a) = log_2(1) = 0.

; 2. Comparamos log_b(a) con el exponente de f(n):
;    - El término O(1) equivale a n^0.
;    - Como log_b(a) = 0 y d = 0, nos encontramos en el caso 2 del Teorema Maestro.

; Por lo tanto, la complejidad asintótica de T(n) es O(log n), que corresponde al número de niveles en la recursión.
