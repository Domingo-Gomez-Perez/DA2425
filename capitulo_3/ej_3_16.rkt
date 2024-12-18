#lang racket

; Exercise 3.16

; Ben Bitdiddle decides to write a procedure to count the number
; of pairs in any list structure.  "It's easy, the number of pairs
; in any structure is the number in the `car` plus the number in 
; the `cdr` plus one more to count the current pair."

; So Ben writes the following procedure (modified for Racket):


(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x)) (count-pairs (mcdr x)) 1)))

; Show that this procedure is not correct.  
; In particular, draw box-and-pointer diagrams representing list
; structures made up of exactly three pairs for which Ben's 
; procedure would return 3; return 4; return 7; never return at all. 

; Encode these diagrams as data structures using Racket `mcons`.


; Caso return 3:

(define x1 (mcons 'a '()))
(define x2 (mcons 'b '()))
(define x3 (mcons 'c '()))

(set-mcdr! x1 x2)
(set-mcdr! x2 x3)

; x1 = [ a | o ]---> [ b | o ]---> [ c | '() ]

(count-pairs x1)
; 3



; Caso return 4:

(define y1 (mcons 'a '()))
(define y2 (mcons 'b '()))
(define y3 (mcons 'c '()))

(set-mcdr! y1 y2)
(set-mcar! y1 y3)
(set-mcar! y2 y3)


; y1 = [ o | o ]---> [ o | '() ]
;        |             |
;        |_____ _______|
;              |   
;              ↓
;            [ c | '() ]

(count-pairs y1)
; 4



; Caso return 7:

(define z1 (mcons 'a '()))
(define z2 (mcons 'b '()))
(define z3 (mcons 'c '()))

(set-mcdr! z1 z2)
(set-mcar! z1 z2)
(set-mcdr! z2 z3)
(set-mcar! z2 z3)


; z1 = [ o | o ]
;        |   |
;        |___|
;        |
;        ↓  
;      [ o | o ]
;        |   |
;        |___|
;        |
;        ↓   
;      [ c | '() ]


(count-pairs z1)
; 7



; Caso never returns:

(define w1 (mcons 'a '()))
(define w2 (mcons 'b '()))
(define w3 (mcons 'c '()))

(set-mcdr! w1 w2)
(set-mcdr! w2 w3)
(set-mcdr! w3 w1)


; w1 = [ a | o ]---> [ b | o ]---> [ c | o ]
;        ↑                               |
;        |_______________________________|

; (count-pairs w1)
; generamos así un bucle infinito
