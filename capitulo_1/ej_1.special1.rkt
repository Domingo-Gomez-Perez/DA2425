#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Special Exercise. Why does this code not work?

(define (f x) 
   (let ((a (+ x 10))
         (b (* a 5)))
        (+ a b)))

(f 2)      ; Fails.  Why?
|#


#| (define (f x) 
   (let ((a (+ x 10))      ; a se define como x + 10
         (b (* a 5)))      ; b se define como a * 5
        (+ a b))
)          ; La funcion suma a y b

(f 2)                        ; Se llama a f 2 |#

#| 
Podemos ver que el error es que a no esta definida.
Esto es asi ya que dentro de let, todas las variables se terminan de definir al final.
Asi, cuando se intenta usar a en la definicion de b, la a no ha terminado de definirse
por lo que no va a poder usarse.

Se podria arreglar usando un let dentro del let con la b. 
|#

(define (f2 x) 
   (let ((a (+ x 10)))
         (let ((b (* a 5))) ; la definimos dentro de un let dentro de let
           (+ a b)))
)
(f2 2)    