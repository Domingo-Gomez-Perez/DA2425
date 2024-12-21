#lang racket

; Original
(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))

; Correccion
(define (count-pairs-mod x)
  (define visitado '()) ; Lista para rastrear los pares visitados
  (define (bucle x)
    (if (not (mpair? x))
        0
        (if (memq x visitado) ; Si ya fue contado
            0
            (begin
              (set! visitado (cons x visitado)) ; Marcar como visitado
              (+ (bucle (mcar x))
                 (bucle (mcdr x))
                 1)))))
  (bucle x))

;Ejemplos:

;Definimos una lista simple:
(define lista-simple (mcons 'a (mcons 'b (mcons 'c null))))

(count-pairs lista-simple) ; Debería devolver 3
(count-pairs-mod lista-simple) ; Debería devolver 3

(define lista-compartida (mcons 'x null))
(define lista-compleja (mcons lista-compartida (mcons lista-compartida null)))

; Deberia devolver 3 ya que shared-list apunta a shared-list que apunta a x por lo tanto tiene 3 elementos
(count-pairs lista-compleja) ; Devuelve 4
(count-pairs-mod lista-compleja) ; Devuelve 3

(define lista-ciclica (mcons 'a null))
(set-mcdr! lista-ciclica lista-ciclica) ; Crea un ciclo: (a . ...)

; Deberia devolver 1 ya que lista-ciclica solo contiene un elemento aunque apunte a si mismo
; (count-pairs cyclic-list) ; Da bucle infinito
(count-pairs-mod lista-ciclica) ; Devuelve 1