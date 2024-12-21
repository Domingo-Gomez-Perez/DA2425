#lang racket
(define (make-frac numer denom) (cons numer denom))
(define (numer frac) (car frac))
(define (denom frac) (cdr frac))

; EJERCICIO 5
; Hecho por: Miguel Martín, Sergio Lanza, Alvaro Gonzalez, David Ruiz del Corro

; En forma iterativa
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

(define lista (list 1 3 5 7 11 13))
(define (obj lista x) (obj-iter lista x))


; Ejemplo de uso
(define (busca_iter x lista) (busca_auxiter x lista 0 (long-iter lista)))
(busca_iter 5 (list 1 2 3 4 5 6))
