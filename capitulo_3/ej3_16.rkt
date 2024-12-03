#lang racket
(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))

;; Retorna 3
(define x3 (mcons 'a (mcons 'b (mcons 'c null))))
(count-pairs x3)
; Diagrama: x --> [a | o] --> [b | o] --> [c | nil]
x3

;; Retorna 4
(define x41 (mcons 'a (mcons 'b '())))
(define x42 (mcons 'c '()))
(set-mcar! x41 x42)
(set-mcar! (mcdr x41) x42)
(count-pairs x41)
; Diagrama: x --> [o | o] --> [o | nil]
;                  |           |
;                  |  _________|
;                  | |
;                  v v
;                 [c | nil]
x41


;; Retorna 7
(define x71 (mcons 'a '()))
(define x72 (mcons 'b '()))
(define x73 (mcons 'c '()))
(set-mcar! x71 x72)
(set-mcdr! x71 x72)
(set-mcar! x72 x73)
(set-mcdr! x72 x73)
(count-pairs x71)
; Diagrama: x --> [o | o]
;                  |   |        
;                  |  _|
;                  | |
;                  v v
;                 [o | o]
;                  |   |        
;                  |  _|
;                  | |
;                  v v
;                 [c | nil]
x71

;; Nunca retorna (genera un ciclo)
(define x-ciclo (mcons 'a (mcons 'b (mcons 'c '()))))
(set-mcdr! (mcdr (mcdr x-ciclo)) x-ciclo)
;(count-pairs x-ciclo)
; Diagrama: x --> [a | o] --> [b | o] --> [c | o]
;                  ^                           |
;                  |___________________________|
x-ciclo
