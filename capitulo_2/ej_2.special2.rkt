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

; mapas con llave-valor

; primero una definicion del record
(define record '((x 1) (y 2) (z 3)))

record

; ahora vamos a hacer el assoc que tiene que encontrar el elemento en el record
(define (assoc key record)
  (cond ((null? record)
         (void)) ; Si hemos llegado al final, no devolvemos nada
        ((eq? key (caar record)) ; el primer elemento de l primer elemento del record (la llave)
         (car record)) ; Si corresponde la llave, lo hemos encontrado
        (else (assoc key (cdr record))))) ; No hemos encontrado pero sigue quedando record

(assoc 'x record) ; '(x 1)
(assoc 'y record) ; '(y 2)
(assoc 'z record) ; '(z 3)
(assoc 'a record) ; void
(newline)
; ya podemos mirar si algo pertenece o no, ahora queremos anhadir y eliminar cosas.

; Eliminar una entrada del registro, si encontramos la entrada, la eliminamos
(define (del-entry key record)
  (cond ((null? record) '()) ; Hemos llegado al final sin encontrar el valor asi que no lo podemos eliminar
        ((eq? key (caar record)) (cdr record)) ; Si la clave coincide (caar), devuelve el resto del registro sin poner esa entrada
        (else (cons (car record) (del-entry key (cdr record)))))) ; vamos entrada a entrada, aqui si guardamos en la que estamos porque no era



; anhadir es mas dificil porque tiene varios casos
; Anhadir o reemplazar, como es un mapa, si la llave ya existe se reemplaza el valor, si no anhade
(define (add-entry key value record)
  (cond ((null? record) ; Si hemos llegado al final no existe la entrada y anhadimos una nueva
         (list (list key value)))          ; Crea un nuevo registro con la entrada
        ((eq? key (caar record))            ; Si la llave coincide:
         (cons (list key value) (cdr record))) ; Reemplaza el valor y conserva el resto para seguir
        (else                                ; Si no coincide
         (cons (car record)                  ; No modifica nada, sigue con la siguiente entrada
               (add-entry key value (cdr record)))))) ; Recur en el resto del registro



(add-entry 'w 4 record)  ; -> ((w 4) (x 1) (y 2) (z 3))
(add-entry 'x 10 record) ; -> ((x 10) (y 2) (z 3))

(newline)

(del-entry 'x record)   ; -> ((y 2) (z 3))
(del-entry 'y record)   ; -> ((y 2) (z 3))
(del-entry 'z record)   ; -> ((y 2) (z 3))