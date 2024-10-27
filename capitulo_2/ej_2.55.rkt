#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.55: Eva Lu Ator types to the interpreter the expression

(car ''abracadabra)
To her surprise, the interpreter prints back quote. Explain.
|#

; esta expresion esta muy resumida, si ampliamos como se escribe de verdad es mas facil de entender
; ''abracadabra en verdad es (quote (quote abracadabra))

; comprobamos
''abracadabra
(quote (quote abracadabra))

; asi, si cogemos con car el primer elemento, vamos que es quote
(car ''abracadabra)
; si usamos el cdr obtendremos la segunda parte (quote abracadabra) pero sigue sin ser lo que queremos
(cdr ''abracadabra)
; para tener lo que queremos necesitaremos coger el primer elemento de lo que queda.
(cadr ''abracadabra)