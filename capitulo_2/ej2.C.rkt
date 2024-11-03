#lang racket


(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

          ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ;
(define (bob-make-box x y w h)
    (attach-tag 'bob-box
         (cons (cons x y) (cons w h))))
          ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ;
(define (alice-make-box x1 y1 x2 y2) 
    (attach-tag 'alice-box
          (cons (cons x1 y1) (cons x2 y2))))
          ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ;

; type-check procedure
(define (bob-box? b) (eq? (type-tag b) 'bob-box))
(define (alice-box? a) (eq? (type-tag a) 'alice-box))

; Other methods (note: must extract the contents from the tagged value)
(define (bob-width b) (car (cdr (contents b))))
(define (bob-height b) 
  (cdr (cdr (contents b))))

(define (alice-width a)
    (abs (- (car (cdr (contents a)))
            (car (car (contents a))))))
            
(define (alice-height a)
  (abs (- (cdr (cdr (contents a)))
    (abs (- (cdr (cdr (contents a)))
            (cdr (car (contents a))))))))

(define (bob-area b)
  (* (bob-width b) (bob-height b)))
(define (alice-area a)
  (* (alice-width a) (alice-height a)))

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

; Métodos genéricos
(define (width box)
  (cond ((bob-box? box) (bob-width box))
        ((alice-box? box) (alice-width box))
        (else (error "Unknown box type"))))

(define (height box)
  (cond ((bob-box? box) (bob-height box))
        ((alice-box? box) (alice-height box))
        (else (error "Unknown box type"))))

(define (area box)
  (cond ((bob-box? box) (bob-area box))
        ((alice-box? box) (alice-area box))
        (else (error "Unknown box type"))))

(display "width de una box de alice (2):")
(width a)
(display "width de una box de bob (3):")
(width b)










