#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Special Challenge Exercise (Binding):
Instead of matching, a more advanced operation is binding. Here is an example:

(bind '(job ?name ?job) record)
;  --> '((name (Hacker Alyssa P)) (job (computer programmer)))

(bind '(?type ?name (?what programmer)) record)
; -->  '((type job) (name (Hacker Alyssa P)) (what computer))

(bind '(job ?what) record)
; --> false (doesn't match)
|#

; Definimos un registro de ejemplo
(define record '(job (Hacker Alyssa P) (computer programmer)))

; La función bind toma un patrón y datos, y devuelve un "binding" (vinculación) de las variables en el patrón con los datos correspondientes
(define (bind pattern data)
  (cond
    ;; 1. Si el patrón es un símbolo, se considera una variable que debe ser vinculada
    ;;    Se retorna una lista con la variable y su valor asociado en el dato
    [(symbol? pattern) (list (list pattern data))]

    ;; 2. Si tanto el patrón como los datos son listas, tenemos que hacer una vinculación recursiva de su estructura
    ;;    Primero, verificamos si las listas tienen la misma longitud
    [(and (list? pattern) (list? data))
     (if (equal? (length pattern) (length data)) ; Las listas deben tener la misma longitud
         (apply append ; Combinamos todos los "bindings"
                (map bind pattern data)) ; Vinculamos cada par de elementos correspondientes
         #f)] ; Si no tienen la misma longitud, no hay coincidencia, retornamos false

    ;; 3. Si ambos son valores simples y son iguales, se retorna una lista vacía (no hace falta vincular nada)
    [(equal? pattern data) '()]

    ;; 4. Si no coinciden en ninguno de los casos anteriores, retornamos false
    ;;    Esto significa que no se puede vincular el patrón con los datos
    [else #f]))

; Casos de prueba

(bind '(job ?name ?job) record)
;  --> '((name (Hacker Alyssa P)) (job (computer programmer)))

(bind '(?type ?name (?what programmer)) record)
; -->  '((type job) (name (Hacker Alyssa P)) (what computer))

(bind '(job ?what) record)
; --> false (doesn't match)
