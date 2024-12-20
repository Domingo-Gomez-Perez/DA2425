#lang racket
(define (make-frac numer denom) (cons numer denom))
(define (numer frac) (car frac))
(define (denom frac) (cdr frac))

;Hecho por: Miguel Martín, Sergio Lanza, Alvaro Gonzalez, David Ruiz del Corro
;EJERCICIO 1

(define lista (list 1 3 5 7 11 13))

(define (long lista) (if (null? lista) (- 1 1) (+ (long (denom lista)) 1)))

;Funcion que devuelva el objeto en la posicion x de la lista
(define (obj-rec lista x y) (if (> x y) (obj-rec (denom lista) x (+ y 1))
                                 (numer lista)))

(define (obj lista x) (obj-rec lista x 0))


(define (busca_aux x lista i j)
  (if (>= i j)
      null
       (let ((m (quotient (+ i (- j 1)) 2))) ;Usamos quotient para la division entera
        (cond ((= (obj lista m) x) m)
              ((< (obj lista m) x) (busca_aux x lista (+ m 1) j))
              (else (busca_aux x lista i m))))))
(define (busca x lista) (busca_aux x lista 0 (long lista)))
(busca 11 lista)

;EJERCICIO 2
;Cota superior para cantidad de llamadas es log2(n) donde n es la longitud de la lista
;La complejidad espacial de este algoritmo está relacionada con el número de llamadas recursivas, como cada llamada recursiva guarda un parametro
;y el número máximo de llamadas activas es O(log2 (n)), por tanto, la complejidad espacial también es de O(log2⁡ (n))
;Complejidad temporal: cada llamada recursiva realiza una operacion de comparacion O(1), o realiza una llamada recursiva, como hemos visto el número de llamadas log2(n)
;por lo que la complejidad temporal es log2(n)

;EJERCICIO 3
;La principal diferencia de uso con terminos bit es que las comparaciones tienen una complejidad temporal de O(log2 (n)),
;debido a que comparar números en binario tiene un coste proporcional a la longitud de su representacion
;Por tanto, al realizar O(log2 (n)) comparaciones, la complejidad temporal nos da en terminos en operaciones bit de O((log2 (n))^2)


;EJERCICIO 4
;Si se puede utilizar en ambos casos,
;Para el primer caso, T(n) = T(n/2) + O(1) donde a = 1 debido a que solo se hace una llamada recursiva en cada paso, b=2 debido a que el problema se reduce a la mitad y el coste
;de combinar las soluciones es constante O(1) por lo que d tomaria valor 0,
;nos situariamos en el segundo caso y por tanto la complejidad temporal es O(log2(n)) y coincide con lo visto anteriormente

;Para el segundo caso, seria de la misma forma anterior, pero como el coste de trabajar con bits es O(log2 (n)), por tanto, La complejidad temporal es:
;O(log2 (n)) * O(log2 (n)) = O((log2 (n))^2) al ver que coincide, podemos corroborar que efectivamente se puede puede usar el teorema maestro


;EJERCICIO 5
;En forma iterativa
(define (long-iter lista)
  (define (aux lista contador)
    (if (null? lista)
        contador
        (aux (cdr lista) (+ contador 1))))
  (aux lista 0))

(define (obj-iter lista x)
  (define (aux lista x y)
    (if (>= y x)
        (car lista)
        (aux (cdr lista) x (+ y 1))))
  (aux lista x 0))

(define (busca_auxiter x lista i j)
  (define (bucle i j)
    (if (>= i j)
        null  
        (let ((m (quotient (+ i (- j 1)) 2)))  
          (cond 
            ((= (obj lista m) x) m)            
            ((< (obj lista m) x) (bucle (+ m 1) j))  
            (else (bucle i m)))))  
    )
  (bucle i j))

; Ejemplo de uso
(define (busca_iter x lista) (busca_auxiter x lista 0 (long lista)))
(busca_iter 5 (list 1 2 3 4 5 6))
