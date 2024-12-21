#lang racket
;Exercise 3.16: Ben Bitdiddle decides to write a procedure to count the number of pairs in any list structure.
;"It's easy," he reasons. "The number of pairs in any structure is the number in the car plus the number in the cdr plus one more to count the current pair."
;So Ben writes the following procedure (modified for Racket):

(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))

;Show that this procedure is not correct. In particular, draw box-and-pointer diagrams representing list structures made up of exactly three pairs for
;which Ben's procedure would return 3; return 4; return 7; never return at all. Encode these diagrams as data structures using Racket mcons.

;Ejemplo donde el procedimiento de Ben da 3

(define list1 (mcons 1 (mcons 2 (mcons 3 '()))))
(count-pairs list1)

; ---------    ---------    ---------   -----
; | 1 | *--->  | 2 | *--->  | 3 | *---> | / |
; ---------    ---------    ---------   -----

;Ejemplo donde el procedimiento de Ben da 4
(define shared (mcons 1 '()))
(define list2 (mcons shared (mcons 2 shared)))
(count-pairs list2)
; ---------    ---------    ---------    -----
; | * | *--->  | 2 | *--->  | * | *--->  | / |
; ---|---      ---------     ---|---     -----
;    v                       ^   |
;    ---------   ----        |   |
;    | 1 | *---> |/|*  ------+---+
;    ---------   ----
;Procesa el primer par de list2 (shared (mcons 2 shared) y suma 1.
;Procesa el car de este par, que es shared(1 '()), y suma 1.
;Procesa el segundo par de list2(2 shared) y suma 1.
;Procesa nuevamente shared desde el cdr del segundo par, y suma 1 otra vez.

;Ejemplo donde el procedimiento de Ben da 7
(define shared2 (mcons 3 (mcons 4 '())))
(define list3 (mcons (mcons 1 shared2) (mcons 2 shared2)))
(count-pairs list3)
;list3 -> ( (1 . shared2) ) -> ( (2 . shared2) )
;             |                      |
;             v                      v
;         ---------             ---------
;         | 3 | *--->           | 3 | *--->
;         ---------   ---       ---------   ---
;         | 4 | *---> |/|       | 4 | *---> |/|
;         ---------   ---       ---------   ---
;1 (par inicial)
;1 (primer par de list3).
;1 (segundo par de list3).
;2 pares de shared2 (primer par)
;2 pares de shared2 (segundo par)

;Ejemplo donde nunca termina
(define ciclo (mcons 1 '()))
(set-mcdr! ciclo ciclo)  ; Crea una estructura cíclica
(define list4 (mcons 3 (mcons 2 ciclo)))
(count-pairs list4)

;list4 -> (3. (2 . cycle))
;                    |
;                    v
;             ---------
;             | 1 | *---|
;             --------- |
;               ^       |
;               |        |
;               ---------


;Entra en un bucle infinito donde nunca acaba