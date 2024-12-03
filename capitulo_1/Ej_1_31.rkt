#lang racket

(define (cuadrado x)
  (* x x))

(define (incrementar x)
  (+ x 2))

; Metodo recursivo
(define (producto-rec term a siguiente b)
  (if (> a b)
      1
      (* (term a)
         (producto-rec term (siguiente a) siguiente b))))

; Metodo iterativo
(define (producto-iter term a siguiente b)
  (define (iter a resultado)
    (if (> a b)
        resultado
        (iter (siguiente a) (* resultado (term a)))))
  (iter a 1))

; Aproximacion
(define (pi-aprox n)
  (* 4
     (/
      (* 2 (producto-iter cuadrado 4 incrementar n))
      (* n (producto-iter cuadrado 3 incrementar (- n 1))))))

; Ejemplos:

(display (pi-aprox 10)) ; Deberia dar 3.30239355001
(newline)
(display (pi-aprox 50)) ; Deberia dar 3.17316407024
(newline)
(display (pi-aprox 100)) ; Deberia dar 3.15733968922

; Observamos que cuanto mas incrementemos n, mas aumenta la precision de la aproximacion
