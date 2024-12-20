#lang racket

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


(define x (mcons 'a (mcons 'b (mcons 'c null))))

(count-pairs x) ; Debería devolver 3
(count-pairs-mod x) ; Debería devolver 3

(define lista-comp (mcons 'x null))
(define lista-compleja (mcons lista-comp (mcons lista-comp null)))

; Deberia devolver 3 ya que shared-list apunta a shared-list que apunta a x por lo tanto tiene 3 elementos
(count-pairs lista-compleja) ; Devuelve 4
(count-pairs-mod lista-compleja) ; Devuelve 3

(define cyclic-list (mcons 'a (mcons 'b (mcons 'c '()))))
(set-mcdr! cyclic-list cyclic-list) ; Crea un ciclo: (a . b. c. a. b. c ...)

; Deberia devolver 3 ya que lista-ciclica solo contiene los elementos a, b, c aunque apunte a si mismo
; (count-pairs cyclic-list) ; Da bucle infinito
(count-pairs-mod cyclic-list) ; Devuelve 3