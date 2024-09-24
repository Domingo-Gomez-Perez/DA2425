#lang racket

;Aparece en mismo numero
10

;Se realiza la suma 5 + 3 y luego + 4
(+ 5 3 4)

;Se resta 9 - 1 y aparece 8
(- 9 1)

; Se realiza la division entre 6/2
(/ 6 2)

; Se realiza primero los parentesis y luego la suma
(+(* 2 4) (- 4 6))

;a pasa a valer 3
(define a 3)

;b pasa a tener un valor de a + 1, es decir, 3 + 1
(define b (+ a 1))

; se realiza los calculos con el valor de a y b dados previamente
(+ a b (* a b))

; se comparan los valores a y b y sale que es falso
(= a b)

;Se hace un if donde si b > a y la multiplicacion de a y b es menor que b entonces printa b si no a
(if (and (> b a) (< b (* a b)))
    b
    a)


;la cond es como un switch en el caso de a valer 4 entonces printa 6, si b vale 4 entonces
; se realiza la suma y si no es ninguna de las dos opciones sale 25
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
; se suma 2 + b si b mayor que a ,o 2 + a si b es menor que a  
(+ 2 (if (> b a) b a))

; se realiza la condicion y esto se multiplica por el valor que da a + 1
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))