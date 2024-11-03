#lang racket

;Exercise 2.B: Modify the "bob" and "alice" code to use tags. 
;Verify that all of the old code still works.


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

(display "Alice-height:")
(alice-height a)
(display "Alice-width:")
(alice-width a)
(display "Alice-area(4):")
(alice-area a)
(display "Bob-area(12):")
(bob-area b)
