#lang racket
;Ejercicio 3.16

(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))

;retorna 3
(define lst1 (mcons 'a (mcons 'b (mcons 'c null))))
(count-pairs lst1)
;[a] --> [b] --> [c] --> null

;retorna 4
(define lst2 (mcons (mcons 'a null) (mcons 'b (mcons 'c null))))
(count-pairs lst2)
;   --> [a] --> null
;  [] --> [b] --> [c] --> null

;retorna 7
(define lst31 (mcons 'a null))
(define lst32 (mcons 'b null))
(define lst33 (mcons 'c null))
(set-mcar! lst31 lst32)
(set-mcar! lst32 lst33)
(set-mcdr! lst31 lst32)
(set-mcdr! lst32 lst33)

(count-pairs lst31)
;  --> [b] --> [c] --> null
; |     | |     |
;[a]----   -----

;nunca retorna
(define lst4 (mcons 'a (mcons 'b (mcons 'c null))))
(set-mcdr! (mcdr (mcdr lst4)) lst4)
(count-pairs lst4)
;[a] --> [b] --> [c]
; |                |
;  ----------------
