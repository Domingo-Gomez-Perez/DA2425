#lang racket
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; Bob's box
(define (bob-make-box x y w h)
    (begin (import-bob-box) (attach-tag 'bob-box
         (cons (cons x y) (cons w h)))))


; Alice's box
(define (alice-make-box x1 y1 x2 y2)
 (begin (import-alice-box) (attach-tag 'alice-box
         (cons (cons x1 y1) (cons x2 y2)))))



; type-check procedure
(define (bob-box? b) (eq? (type-tag b) 'bob-box))
(define (alice-box? b) (eq? (type-tag b) 'alice-box))


(define registry (make-hash))

(define (register name tag proc)
   (hash-set! registry (list name tag) proc))

(define (lookup name object)
   (hash-ref registry (list name object)))

; Generic procedure
(define (width box)
    ((lookup 'width (type-tag box)) box))

(define (height box)
    ((lookup 'height (type-tag box)) box))

(define (area box)
    ((lookup 'area (type-tag box)) box))




(define (import-bob-box)
    (define (bob-width b) (car (cdr (contents b))))
(define (bob-height b) (cdr (cdr (contents b))))

(define (bob-area box)
    (* (bob-width box) (bob-height box)))
   (register 'width 'bob-box bob-width)
   (register 'height 'bob-box bob-height)
  (register 'area 'bob-box bob-area)

)


(define (import-alice-box)
  (define (alice-width box)
   (abs (- (car (cdr (contents box)))
           (car (car (contents box))))))

(define (alice-height box)
   (abs (- (cdr (cdr (contents box)))
           (cdr (car (contents box))))))

(define (alice-area box)
    (* (alice-width box) (alice-height box)))
   (register 'width 'alice-box alice-width)
   (register 'height 'alice-box alice-height)
  (register 'area 'alice-box alice-area)
)

; Ejercicio E, añadimos el import donde se use, en nuestro caso en el make-box
;no podriamos añadir el make-box al import debido a que no tendriamos ningun lugar donde ejecutarlo segun se necesite, no podriamos importar por ejemplo bob solo en el caso en que se use bob-box
(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))
(width a)
;2
(width b)
;3
(height a)
;2
(height b)
;4
(area a)
;4
(area b)
;12