#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.33: Fill in the missing expressions to complete the following definitions
of some basic list-manipulation operations as accumulations:

(define (map p sequence)
  (accumulate (lambda (x y) ⟨??⟩)
              nil sequence))

(define (append seq1 seq2)
  (accumulate cons ⟨??⟩ ⟨??⟩))

(define (length sequence)
  (accumulate ⟨??⟩ 0 sequence))
|#

; el accumulate para comprobar
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))

; la longitud
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

; el append (tiene que ser primero seq2 porque se construye desde el final)
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

; el map
(define (map p sequence)
  (accumulate (lambda (x y) (cons(p x) y))
              null sequence))

(define (reverse lst)
  (define (reverse-iter lst acc)
    (if (null? lst)
        acc
        (reverse-iter (cdr lst) (cons (car lst) acc))))
  (reverse-iter lst '()))

; el for
(define (foreach sequence order)
  (accumulate (lambda (x y)(order x))
              null sequence))

; pruebas
(define lista (list 1 2 3 4))
(define lista2 (list 5 6 7 8))

(length lista)

(append lista lista2)

(reverse lista)

(foreach lista display)

(map (lambda (x) (* x x)) lista)