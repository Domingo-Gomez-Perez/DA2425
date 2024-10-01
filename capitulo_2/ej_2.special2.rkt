#lang racket

#|
Hecho por 
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Special Exercise (Records): In many programming languages, it is common to represent records as key-value pairs (sometimes known as a mapping). For example, you might write:

(define record '((x 1) (y 2) (z 3)))
Write a procedure (assoc key record) that finds the entry with a given key:

(assoc 'y record)      ; -> (y 2)
Write a procedure (add-entry key value record) that adds or replaces an entry (returning a new record as a result).

(add-entry 'w 4 record)  ; -> ((x 1) (y 2) (z 3) (w 4))
(add-entry 'x 10 record) ; -> ((x 10) (y 2) (z 3))
Write a procedure (del-entry key record) that deletes an entry (returning a new record).

(del-entry `x record)   ; -> ((y 2) (z 3))
|#