#lang racket 

(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; Crear una caja de Bob
(define (bob-make-box x y w h)
  (attach-tag 'bob-box
              (cons (cons x y) (cons w h))))

; Crear una caja de Alice
(define (alice-make-box x1 y1 x2 y2) 
  (attach-tag 'alice-box
              (cons (cons x1 y1) (cons x2 y2))))

; Procedimientos de verificación de tipo
(define (bob-box? b) (eq? (type-tag b) 'bob-box))
(define (alice-box? a) (eq? (type-tag a) 'alice-box))

; Métodos específicos para Bob
(define (bob-width b) (car (cdr (contents b))))
(define (bob-height b) (cdr (cdr (contents b))))

(define (bob-area b)
  (* (bob-width b) (bob-height b)))

; Métodos específicos para Alice
(define (alice-width a)
  (abs (- (car (cdr (contents a))) (car (car (contents a)))))) ; width es la diferencia entre x2 y x1

(define (alice-height a)
  (abs (- (cdr (cdr (contents a))) (cdr (car (contents a)))))) ; height es la diferencia entre y2 y y1

(define (alice-area a)
  (* (alice-width a) (alice-height a)))

; Crear un registro mutable
(define registry (make-hash))

; Función para registrar procedimientos
(define (register name tag proc)
  (hash-set! registry (list name tag) proc))

; Función para buscar procedimientos en el registro
(define (lookup name object)
  (hash-ref registry (list name (type-tag object))))

; Registrar procedimientos en el registro
(register 'width 'bob-box bob-width)
(register 'width 'alice-box alice-width)
(register 'height 'bob-box bob-height)
(register 'height 'alice-box alice-height)
(register 'area 'bob-box bob-area)
(register 'area 'alice-box alice-area)

; Procedimientos genéricos para obtener ancho, alto y área
(define (generic-width box)
  ((lookup 'width box) box))

(define (generic-height box)
  ((lookup 'height box) box))

(define (generic-area box)
  ((lookup 'area box) box))



; Crear instancias de cajas
(define a (alice-make-box 1 2 3 4)) ; Crea una caja de Alice
(define b (bob-make-box 1 2 3 4))    ; Crea una caja de Bob


(newline)

; Verificar el comportamiento correcto
(display a)(newline)
(displayln (format "Box A: Width = ~a, Height = ~a, Area = ~a" 
                   (generic-width a) (generic-height a) (generic-area a)))

(display b)(newline)
(displayln (format "Box B: Width = ~a, Height = ~a, Area = ~a" 
                   (generic-width b) (generic-height b) (generic-area b)))
(newline)
