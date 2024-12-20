#lang racket
(define (make-frac numer denom) (cons numer denom))
(define (numer frac) (car frac))
(define (denom frac) (cdr frac))

; EJERCICIO 1
; Hecho por: Miguel Martín, Sergio Lanza, Alvaro Gonzalez, David Ruiz del Corro

(define lista (list 1 3 5 7 11 13))

(define (long lista) (if (null? lista) (- 1 1) (+ (long (denom lista)) 1)))

; Funcion que devuelva el objeto en la posicion x de la lista
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
