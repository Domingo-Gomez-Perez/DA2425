#lang racket

#|
Exercise 2.D: A registry to your code. Register various width/height procedures with the registry.
Write generic width/height/area procedures.

|#


#|
# Pseudo-code. Not Scheme.
registry = {
    '(width bob-box)    -> bob_width
    '(width alice-box)  -> alice-width
    ...
}
|#


;(define (width box)
 ;   (registry['width (type-tag box)] box))

;(make-hash)              ; Create a mutable hash table
;(hash-set! h key val)    ; Add an entry
;(hash-ref h key)         ; Look up a value


(define (bob-box? b)
  (equal? (type-tag b) 'bob-box))

(define (alice-box? b)
  (equal? (type-tag b) 'alice-box))

; Bob's box
(define (bob-make-box x y w h)
  (attach-tag 'bob-box (cons (cons x y) (cons w h))))

(define (bob-width box)
   (car (cdr (contents box))))

(define (bob-height box)
   (cdr (cdr (contents box))))

(define (bob-area box)
    (* (bob-width box) (bob-height box)))


; Alice's box
(define (alice-make-box x1 y1 x2 y2)
 (attach-tag 'alice-box (cons (cons x1 y1) (cons x2 y2))))

(define (alice-width box)
   (abs (- (car (cdr (contents box)))
           (car (car (contents box))))))

(define (alice-height box)
   (abs (- (cdr (cdr (contents box)))
           (cdr (car (contents box))))))

(define (alice-area box)
    (* (alice-width box) (alice-height box)))



;Tag

(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

;make-hash es una funcion que crea un mapa, hash-set sirve para crear una entrada en el mapa que le indicas (ej:h)
;para una determinada llave que tiene asociada un valor

;hash-ref sive para obtener del mapa que le indiques si está la llave, el valor asociado a ella, si no está la llave dará el error
;Example
;(define h (make-hash))
;(hash-set! h 'foo 42)
;(hash-set! h 'bar 37)
;(hash-ref h 'foo)        ; -> 42
;(hash-ref h 'bar)        ; -> 37


(define registry (make-hash))

(define (register name tag proc)
   (hash-set! registry (list name tag) proc))

(define (lookup name object)
 (hash-ref registry (list name object)))


; Register procedures (in advance)
(register 'width 'bob-box bob-width)
(register 'width 'alice-box alice-width)


(register 'height 'bob-box bob-height)
(register 'height 'alice-box alice-height)


(register 'area 'bob-box bob-area)
(register 'area 'alice-box alice-area)

; Generic procedure
(define (width box)
    ((lookup 'width (type-tag box)) box))


(define (height box)
    ((lookup 'height (type-tag box)) box))

(define (area box)
    ((lookup 'area (type-tag box)) box))

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

;Ejemplos para a
(display "Anchura a")
(newline)
(width b)


(newline)
(display "Altura a")
(newline)
(height b)


(newline)
(display "Area a")
(newline)
(area b)
(newline)


;Ejemplos para b

(newline)
(display "Anchura b")
(newline)
(width b)
(newline)


(display "Altura b")
(newline)
(height b)
(newline)


(display "Area b")
(newline)
(area b)
(newline)