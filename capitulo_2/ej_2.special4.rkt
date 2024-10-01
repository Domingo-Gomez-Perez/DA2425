#lang racket

#|
Hecho por 
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Special Challenge Exercise (Binding): Instead of matching, a more advanced operation is binding. Here is an example:

(bind '(job ?name ?job) record)
;  --> '((name (Hacker Alyssa P)) (job (computer programmer)))

(bind '(?type ?name (?what programmer)) record)
; -->  '((type job) (name (Hacker Alyssa P)) (what computer))

(bind '(job ?what) record)
; --> false (doesn't match)
|#
