#lang racket

;Hecho por 
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Special Exercise. Why does this code not work?

(define (f x) 
   (let ((a (+ x 10))
         (b (* a 5)))
        (+ a b)))

(f 2)      ; Fails.  Why?
|#


(define (f x) 
   (let ((a (+ x 10))      ; a se define como x + 10
         (b (* a 5)))      ; b se define como a * 5
        (+ a b)))          ; La funcion suma a y b

(f 2)                        ; Calling the function with 2