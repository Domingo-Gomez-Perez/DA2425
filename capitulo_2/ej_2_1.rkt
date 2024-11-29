#lang racket
(define (gcd a b) ;funcion del maximo comun divisor
  (if (= b 0)
      (abs a)
      (gcd b (remainder a b))))

(define (make-rat numer denom)
  (let* ((g (gcd numer denom))  ; Simplifica la fraccion
         (numer-simplified (/ numer g))
         (denom-simplified (/ denom g)))
    (cond ((< denom-simplified 0) ; Se asegura de que el denominador es positivo
           (cons (- numer-simplified) (- denom-simplified)))
          (else
           (cons numer-simplified denom-simplified)))))

; Funciones para coger el numerador o el denominador de una fraccion
(define (numer rat) (car rat))
(define (denom rat) (cdr rat))

(define (print-rat rat)
  (let ((n (numer rat))
        (d (denom rat)))
    (display n)     ; Muestra el numerador
    (display "/")   ; Muestra el separador "/"
    (display d)     ; Muestra el denominador
    (newline)))     ; Inserta un salto de línea

; Ejemplos de uso
(define rat1 (make-rat 4 -6))  ; Deberia devolver -2/3
(define rat2 (make-rat -4 6))  ; Deberia devolver -2/3
(define rat3 (make-rat 4 6))   ; Deberia devolver 2/3
(define rat4 (make-rat -4 -6)) ; Deberia devolver 2/3

(print-rat rat1) ; -2/3
(print-rat rat3) ; 2/3

(numer rat2) ; -2
(denom rat2) ; 3

(numer rat4) ; 2
(denom rat4) ; 3
