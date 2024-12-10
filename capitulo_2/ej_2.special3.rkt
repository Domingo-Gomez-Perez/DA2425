#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Special Exercise (Patterns):
Sometimes it's useful to match patterns in data.
For example, consider this record:

(define record '(job (Hacker Alyssa P) (computer programmer)))

Write a procedure (match pattern data) that matches structure:

(match '(job ? ?) record)           ; --> true
(match '(job ? (? coder)) record)   ; --> false
(match '(? ? (computer ?)) record)  ; --> true
|#

; Definimos un registro de ejemplo que contiene un par de listas
; En este caso, un trabajo con dos elementos dentro: una lista de detalles de la persona
; y una lista de información sobre su profesión.
(define record '(job (Hacker Alyssa P) (computer programmer)))

; La función match toma un patrón y un dato, y verifica si el patrón coincide con el dato dado
(define (match pattern
          data)

  ; 1. Si el patrón y los datos son exactamente iguales, entonces hacemos una coincidencia exacta
  (cond
    [(equal? pattern data) #t] ; Si son iguales, devolvemos verdadero

    ; 2. Si tanto el patrón como los datos son listas, hacemos una comparación recursiva
    ;    sobre cada elemento de las listas usando andmap
    [(and (list? pattern) (list? data))
     (andmap (lambda (p d)
               (match p
                 d))
             pattern
             data)] ; Compara recursivamente cada par de elementos

    ; 3. Si el patrón es el comodín '?', siempre hace una coincidencia con cualquier valor
    [(eq? '? pattern) #t] ; El comodín siempre hace una coincidencia, devolvemos verdadero

    ; 4. Si no coincide con ninguno de los casos anteriores, devolvemos falso
    [else #f]))

; Pruebas

; Coincide con el patrón '(job ? ?)', ya que los comodines '?' pueden coincidir con cualquier valor
(display (match '(job ? ?)
           record)) ; --> true
(newline)

; No coincide con el patrón '(job ? (? coder))', porque la sublista '(computer programmer)'
; no tiene el valor 'coder' como segundo elemento
(display (match '(job ? (? coder))
           record)) ; --> false
(newline)

; Coincide con el patrón '(? ? (computer ?))', ya que el comodín puede coincidir con "Hacker" y "Alyssa",
; y la sublista '(computer programmer)' tiene "computer" como su primer elemento
(display (match '(? ? (computer ?))
           record)) ; --> true
(newline)
