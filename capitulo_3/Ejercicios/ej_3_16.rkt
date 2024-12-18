#lang racket
(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))

(define a (mcons 'a (mcons 'b (mcons 'c null))))
(count-pairs a) ; En este caso el metodo funciona correctamente
; Representación caja y puntero: (a) --> (b) --> (c) --> null


; Caso con 3 pares con resultado 4
(define e (mcons 'c null))              ; Último par
(define y (mcons 'b null))              ; Segundo par
(define z (mcons 'a (mcons e y)))       ; Raíz que referencia a `b` y `c`

(count-pairs z) ; Debería retornar 4

;   (a) --> +------+
;           |      |
;           v      v
;      (c . null) (b . null)



; Caso con 3 pares con resultado 7
(define c (mcons 'c null))              ; Último par
(define b (mcons 'b c))                 ; Segundo par
(define x (mcons 'a (mcons b a)))       ; Raíz que referencia a `b` y `c`

;(a) --> +------+
;        |      |
;        v      v
;   (b) --> (c) --> null
;    ^          
;    |
;    +----------------+


(count-pairs x) ; Debería retornar 7


(define d (mcons 'a null))
(set-mcdr! d (mcons 'b d)) ; Crear un bucle indinito
(count-pairs d) ; No termina
;(a) --> (b) --
; ↑               |
; |---------------|


