#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.E: Poner las funciones genéricas "bob" y "alice" dentro de su propio espacio de nombres.
|#

; Registro y funciones de registro
(define registry (make-hash))

(define (register name tag proc)
  (hash-set! registry (list name tag) proc))

(define (lookup name tag)
  (hash-ref registry (list name tag)))

; Funciones para los tags
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; Espacio de nombres de Alice
(define (import-alice-box)
  (define (alice-make-box x y w h)
    (attach-tag 'alice-box (cons (cons x y) (cons w h))))

  (define (alice-width box)
    (abs (- (car (cdr (contents box)))
            (car (car (contents box))))))

  (define (alice-height box)
    (abs (- (cdr (cdr (contents box)))
            (cdr (car (contents box))))))

  (define (alice-area box)
    (* (alice-width box) (alice-height box)))

  ; Registrar las funciones de Alice
  (register 'width 'alice-box alice-width)
  (register 'height 'alice-box alice-height)
  (register 'area 'alice-box alice-area)

  ; Retornar el constructor para crear cajas de Alice
  alice-make-box)

; Espacio de nombres de Bob
(define (import-bob-box)
  (define (bob-make-box x y w h)
    (attach-tag 'bob-box (cons (cons x y) (cons w h))))

  (define (bob-width box)
    (car (cdr (contents box))))

  (define (bob-height box)
    (cdr (cdr (contents box))))

  (define (bob-area box)
    (* (bob-width box) (bob-height box)))

  ; Registrar las funciones de Bob
  (register 'width 'bob-box bob-width)
  (register 'height 'bob-box bob-height)
  (register 'area 'bob-box bob-area)

  ; Retornar el constructor para crear cajas de Bob
  bob-make-box)

; Importar los espacios de nombres de Alice y Bob
(define alice-make-box (import-alice-box))
(define bob-make-box (import-bob-box))

; Funciones genéricas
(define (width box)
  ((lookup 'width (type-tag box)) box))

(define (height box)
  ((lookup 'height (type-tag box)) box))

(define (area box)
  ((lookup 'area (type-tag box)) box))

; Ahora podemos crear cajas usando los constructores
(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

; Probar las funciones de ancho, alto y área
(display (width a))   ; -> 2
(newline)
(display (height a))  ; -> 2
(newline)
(display (area a))    ; -> 4
(newline)

(display (width b))   ; -> 3
(newline)
(display (height b))  ; -> 4
(newline)
(display (area b))    ; -> 12
(newline)

; Mostrar las estructuras de las cajas
(display a)
(newline)
(display b)
(newline)
