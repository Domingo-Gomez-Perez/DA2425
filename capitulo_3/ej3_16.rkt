#lang racket

(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))

;3
(define x1 (mcons 'x (mcons 'y (mcons 'z null))))
(count-pairs x1)
;[x]->[y]->[z]->null

;4
(define x2 (mcons (mcons 'x null) (mcons 'y (mcons 'z null))))
(count-pairs x2)
;   ->[x]->null
;  []->[y]->[z]->null

;7
(define x3 (mcons 'x null))
(define x4 (mcons 'y null))
(define x5 (mcons 'z null))
(set-mcar! x3 x4)
(set-mcar! x4 x5)
(set-mcdr! x3 x4)
(set-mcdr! x4 x5)

(count-pairs x3)
;  ->[y]->[z]->null
; |   | |     |
;[x]---  -----

;no retorna
(define x6 (mcons 'x (mcons 'y (mcons 'z null))))
(set-mcdr! (mcdr (mcdr x6)) x6)
(count-pairs x6)
;[x]->[y]->[z]
; |         |
;  ---------