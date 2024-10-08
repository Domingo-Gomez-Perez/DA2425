#lang racket
(define (f x) 
   (let ((a (+ x 10))
         (b (* a 5)))
         (+ a b))
)
(f 2)      ; Fails.  Why?

; Porque se está referenciando la variable `a` dentro de una definición de let antes de que haya sido definida.
; Las variables dentro de un let no pueden referirse entre sí porque las expresiones que les asignan valor se evalúan de manera simultánea,
; no secuencial. En este caso, se está intentando definir `b` usando `a`, pero `a` no está disponible hasta después de que todas las variables del let han sido evaluadas.

(define x 5)
(+ (let ((x 3))
        (+ x (* x 10)))
   x) ; Answer?

; -> 33 (inner) + 5 (outer) -> 38
