#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.39: Complete the following definitions of reverse (Exercise 2.18) in
terms of fold-right and fold-left from Exercise 2.38.

(define (reverse sequence)
  (fold-right
   (lambda (x y) ⟨??⟩) nil sequence))

(define (reverse sequence)
  (fold-left
   (lambda (x y) ⟨??⟩) nil sequence))
|#

; necesitamos el fold left y right
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))


; ahora solo hay que completar las ??

; el fold left va desde  la izquierda hacia la derecha por lo que solo
; poniendo cons, los elementos van a acabar al reves de como queremos.
; así si cambiamos x por y, se pondran al reves y todos en la misma lista

(define (reverse1 sequence)
  (fold-left
   (lambda (x y) (cons y x)) null sequence))

; aqui los elementos van desde la derecha hacia la izquierda justo lo que queremos
; pero solo usando cons no vamos a conseguir el resultado.
; y si cambiamos x por y se pondra todo en distintas listas ya que se van anhadiendo uno a uno
; por lo que la manera mas facil será usar append para juntar las listas en una

(define (reverse2 sequence)
  (fold-right
   (lambda (x y) (append y (list x))) null sequence))



(define lista (list 1 2 3 4))


(reverse1 lista)
(reverse2 lista)