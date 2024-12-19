#lang racket

;Types procedures
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

(define (bob-box? b) (eq? (type-tag b) 'bob-box))
(define (alice-box? b) (eq? (type-tag b) 'alice-box))


; Register
(define registry (make-hash))

(define (register name tag proc)
   (hash-set! registry (list name tag) proc))

(define (lookup name object)
   (hash-ref registry (list name (type-tag object))))



; Generic procedures
(define (width box)
    (lookup 'width box) box)

(define (height box)
    (lookup 'height box) box)

(define (area box)
    ((lookup 'area box) box))


  (define (bob-make-box  x y w h)
  (attach-tag 'bob-box
  (cons (cons x y) (cons w h))))

; Bob's box
(define (import-bob-box)


  (define (width box)
   (car (cdr (contents box))))

  (define (height box)
    (cdr (cdr (contents box))))

  (define (area box)
    (* (width box) (height box)))

 (register 'width 'bob-box width)
 (register 'height 'bob-box height)
 (register 'area 'bob-box area)
  )



(define (alice-make-box x1 y1 x2 y2)
  (attach-tag 'alice-box
 (cons (cons x1 y1) (cons x2 y2))))

; Alice's box
(define (import-alice-box)
  
(define (width box)
   (abs (- (car (cdr (contents box)))
           (car (car (contents box))))))

(define (height box)
   (abs (- (cdr (cdr (contents box)))
           (cdr (car (contents box))))))

(define (area box)
    (* (width box) (height box)))

 (register 'width 'alice-box width)
 (register 'height 'alice-box height)
 (register 'area 'alice-box area)

  )
(import-bob-box)
(import-alice-box)




(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))





;Resultados
(area a)

(area b)


a
b