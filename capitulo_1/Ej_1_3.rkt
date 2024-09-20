#lang racket
(define (suma-cuadrados-grandes a b c)
  (let ((pequeno (min a b c)))  ; Busca el menor de los tres valores asignando el menor a la variable local "pequeno"
    (+ (* a a)                   ; Sumas todos los cuadrados
       (* b b)
       (* c c)
       (- (* pequeno pequeno))))) ; Restas el cuadrado del menor usando la variable local que hemos definido anteriormente

; En resumen, en vez de comprobar que valores son los mas altos, buscas el menor y restas su cuadrado a la suma total de los cuadrados