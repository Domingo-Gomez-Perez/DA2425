#lang racket
; Basic HashMap methods
(define registry (make-hash))
(define (register name tag proc) (hash-set! registry (list name tag) proc))
(define (lookup name tag) (hash-ref registry (list name tag)))

; Basic tagging methods
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; Generical methods
(define (width box) ((lookup 'width (type-tag box)) box))
(define (height box) ((lookup 'height (type-tag box)) box))
(define (area box) (* (width box) (height box)))

; BOB
(define (bob-make-box x y w h)
(attach-tag 'bob-box (cons (cons x y) (cons w h))))

(define (import-bob-box)
(define (bob-width b) (car (cdr (contents b))))
(define (bob-height b) (cdr (cdr (contents b))))

(register 'width 'bob-box bob-width)
(register 'height 'bob-box bob-height)
)


; ALICE
(define (alice-make-box x1 y1 x2 y2)
(attach-tag 'alice-box (cons (cons x1 y1) (cons x2 y2)))
)

(define (import-alice-box)
(define (alice-width box)
(abs (- (car (cdr (contents box)))
(car (car (contents box))))))

(define (alice-height box)
(abs (- (cdr (cdr (contents box)))
(cdr (car (contents box))))))


(register 'width 'alice-box alice-width)
(register 'height 'alice-box alice-height)
)

; Ejemplos
(import-bob-box)
(import-alice-box)

(display "Bob:\n")
(define b (bob-make-box 1 2 3 4))
(display "Ancho:")
(width b)   ; Debería retornar 3
(display "Alto:")
(height b)  ; Debería retornar 4
(display "Area:")
(area b)    ; Debería retornar 12


(display "\n")

(display "Alice:\n")
(define a (alice-make-box 1 2 3 4))
(display "Ancho:")
(width a)   ; Debería retornar 2
(display "Alto:")
(height a)  ; Debería retornar 2
(display "Area:")
(area a)    ; Debería retornar 4

